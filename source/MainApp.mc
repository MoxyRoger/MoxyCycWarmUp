import Toybox.Activity;
import Toybox.ActivityRecording;
import Toybox.AntPlus;
import Toybox.Application;
import Toybox.FitContributor;  //maybe don't need
import Toybox.Lang;
import Toybox.Position;
import Toybox.Sensor;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;

// Some buttons are handled differently and identifed with a number passed in.
const G_Start_Button = WatchUi.loadResource(Rez.Strings.StartActivityButton).toNumber();
const G_Lap_Button = WatchUi.loadResource(Rez.Strings.LapButton).toNumber();

// Palette size is used to identify some colors that are not available on smaller color palet sizes
const G_Palette_Sz = WatchUi.loadResource(Rez.Strings.PaletteSize).toNumber();

// helper function
function format_elapsed_time(seconds) {
    var hh = seconds / 3600;
    var mm = seconds / 60 % 60;
    var ss = seconds % 60;

    if (hh != 0) {
        return Lang.format("$1$:$2$:$3$", [
                               hh,
                               mm.format("%02d"),
                               ss.format("%02d")
                           ]);
    }
    else {
        return Lang.format("$1$:$2$", [
                               mm,
                               ss.format("%02d")
                           ]);
    }
}

enum {
    VIBRATE_PERIOD     = 1000,
    VIBRATE_DUTY_CYCLE = 50
}

//enum{
//    BASIC_RESISTANCE,
//    TARGET_POWER
//}

enum{
    STEP_INIT,
    COUNTDOWN,
    CV1,
    CV2,
    REST1,
    ACCELS,
    REST2,
    STOP
}


const BP1_DEFAULT = 100;
const BP2_DEFAULT = 200;
const CVPREP_DEFAULT = 300;
const CVREST_DEFAULT = 60;
const ACCEL_DEFAULT = 20;
const ACCELREST_DEFAULT = 60;
const NUMACCEL_DEFAULT = 5;
var IS_FEC_NATIVE = false;

class MoxyCycWarmup extends Application.AppBase {
    hidden var mTimer;
    hidden var mMO2;
    hidden var mFEC;
    hidden var mFECControl;
    hidden var mViewAlert;
    hidden var mDelegate;
    hidden var mActivity;
    hidden var mFitContrib;
    hidden var mInfo;
    hidden var pwrHead = 0;
    hidden var pwrTail = 0;
    hidden var pwrSize = 10;
    hidden var pwrBuffer;


    var btnAlert;
    var targPwr1 = 0;
    var targPwr2 = 0;
    var BreakPt1 = 0;
    var BreakPt2 = 0;
    var stepStartTime = 0;
    var stepIndex = STEP_INIT;
    var stepDuration = 1000;   // load durations in milliseconds
    var accelerator = 0;
    //var is_lap_beg_marked = false;
    //var is_lap_end_marked = false;
    var pwrSmooth = 0;

    function initialize() {
        AppBase.initialize();
        mTimer = new Timer.Timer();
        btnAlert = BTN_NONE;
        if (Toybox.AntPlus has :FitnessEquipment) {
            IS_FEC_NATIVE = true;
        }
        //IS_FEC_NATIVE = false;  // ToDo: Remove after testing
        pwrSize = 10;
        pwrBuffer = new[pwrSize+1];
    }
    
    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        mMO2 = new MO2Sensor();
        if (IS_FEC_NATIVE) {
            mFEC = new MyFitnessEquipmentListener();
            mFECControl = new AntPlus.FitnessEquipment(mFEC);
        }
        else {
            mFEC = new FECTrainer();
            mFECControl = mFEC;
        }
        
        mViewAlert = new ViewAlert(mMO2);

        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE,
                                  Sensor.SENSOR_BIKECADENCE,
                                  Sensor.SENSOR_BIKESPEED,
                                  Sensor.SENSOR_BIKEPOWER]);

        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS,method(:onPositionCallback));

		createActivity();
        mTimer.start(self.method(:onTimerCallback), 1000, true);
        resetSmooth();
        pwrSmooth = 0;
    }

    function onStop(state) {
        mTimer.stop();

        // disable events
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPositionCallback));

        // disable sensors
        Sensor.setEnabledSensors([]);

        // close the MO2 sensor
        mMO2.release();
    }

    function getInitialView() {
        var view;
        view = new MCycView0(mMO2, mFEC, mViewAlert);
        mDelegate = new MCycDelegate(0, view, mMO2, mFEC, mViewAlert);
        return [ view, mDelegate ];
    }

    public function onPositionCallback(info as Position.Info) as Void{
        
    }

    function onTimerCallback() {
		if (mFitContrib != null) {
			if (mActivity != null) {
				mFitContrib.compute(mMO2);
			}
		}
        mInfo = Activity.getActivityInfo();
        checkStepTime();
        smoothPower();
        WatchUi.requestUpdate();
    }

    function checkStepTime() {
        if (mInfo.timerTime - stepStartTime > ((stepDuration) - 500)) {
            incrementStep();
        }
    }

    function smoothPower() {
        if (mInfo != null) {
			if (mInfo.currentPower != null && mInfo.currentPower != 0) {
                pwrBuffer[pwrHead] = mInfo.currentPower;
            
                pwrHead = (pwrHead + 1) % (pwrSize+1);
                if (pwrHead == pwrTail) {
                    pwrTail = (pwrTail + 1) % (pwrSize+1);
                }
                var i = pwrTail;
                var count = 0;
                pwrSmooth = 0.0;
                do {
                    pwrSmooth  += pwrBuffer[i];
                    count += 1;
                    i = (i + 1) % (pwrSize+1);
                }
                while (i != pwrHead);
                pwrSmooth  = pwrSmooth  / count;
                //System.println("i: " + i + " ct: " + count + " ipwr: " + mInfo.currentPower.format("%.2f") + " spwr: " + pwrSmooth.format("%.2f"));
            }
            else {
                resetSmooth();
                pwrSmooth = 0;
            }
        }
        else {
            resetSmooth();
            pwrSmooth = 0;
        }
    }

    function resetSmooth(){
        pwrTail = 0;
        pwrHead = 0;
    }

    function getStoredValue(name, def_value){
        var value = Storage.getValue(name);
        if (value == null) {
            value = def_value;
        }
        return value;
    }

    function incrementStep() {
        if (stepIndex == REST2) {
            if (accelerator >= getStoredValue("numaccel", NUMACCEL_DEFAULT)) {
                stepIndex = STOP;
            }
            else {
                stepIndex = ACCELS;
            }
        }
        else if (stepIndex == ACCELS) {
            stepIndex = REST2;
        }
        else if(stepIndex < ACCELS) {
            stepIndex = stepIndex + 1;
        }
        
        stepStartTime = mInfo.timerTime;
        switch(stepIndex) {
            case COUNTDOWN:
                stepDuration = 5 * 1000;
                targPwr1 = 0;
                targPwr2 = 0;
                mFECControl.controlEquipment(AntPlus.TRAINER_SLOPE, 2.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_SURFACE, 0.004);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_COEFF, 1.25);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_SPEED, 0);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_DRAFT_FACTOR, 1.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_USER_WEIGHT, 75);
                mFECControl.controlEquipment(AntPlus.TRAINER_BIKE_WEIGHT, 10);
                break;
            case CV1:
                btnAlert = STP_CV1;
                stepDuration = getStoredValue("cvprepdur", CVPREP_DEFAULT) * 1000;
                BreakPt1 = getStoredValue("BP1-watts", BP1_DEFAULT);
                targPwr1 = 0.60 * BreakPt1;
                targPwr2 = 0.85 * BreakPt1;
                mFECControl.controlEquipment(AntPlus.TRAINER_SLOPE, 0.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_SURFACE, 0.004);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_COEFF, 1.00);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_SPEED, 0);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_DRAFT_FACTOR, 1.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_USER_WEIGHT, 75);
                mFECControl.controlEquipment(AntPlus.TRAINER_BIKE_WEIGHT, 9);
                break;
            case CV2:
                btnAlert = STP_CV2;
                stepDuration = getStoredValue("cvprepdur", CVPREP_DEFAULT) * 1000;
                BreakPt1 = getStoredValue("BP1-watts", BP1_DEFAULT);
                targPwr1 = 0.70 * BreakPt1;
                targPwr2 = 0.95 * BreakPt1;
                mFECControl.controlEquipment(AntPlus.TRAINER_SLOPE, 0.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_SURFACE, 0.004);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_COEFF, 1.00);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_SPEED, 0);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_DRAFT_FACTOR, 1.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_USER_WEIGHT, 75);
                mFECControl.controlEquipment(AntPlus.TRAINER_BIKE_WEIGHT, 9);
                break;
            case REST1:
                btnAlert = STP_REST;
                stepDuration = getStoredValue("cvrestdur", CVREST_DEFAULT) * 1000;
                BreakPt1 = getStoredValue("BP1-watts", BP1_DEFAULT);
                targPwr1 = 0;
                targPwr2 = 0.25 * BreakPt1;
                mFECControl.controlEquipment(AntPlus.TRAINER_SLOPE, 0.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_SURFACE, 0.004);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_COEFF, 0.75);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_SPEED, 0);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_DRAFT_FACTOR, 1.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_USER_WEIGHT, 75);
                mFECControl.controlEquipment(AntPlus.TRAINER_BIKE_WEIGHT, 9);
                pwrSize = 3;
                resetSmooth();
                break;
            case ACCELS:
                btnAlert = STP_STEP;
                stepDuration = getStoredValue("acceldur", ACCEL_DEFAULT) * 1000;
                BreakPt2 = getStoredValue("BP2-watts", BP2_DEFAULT);
                accelerator = accelerator + 1;
                targPwr1 = (1.10 + 0.1 * accelerator) * BreakPt2;
                targPwr2 = (1.50 + 0.1 * accelerator) * BreakPt2;
                mFECControl.controlEquipment(AntPlus.TRAINER_SLOPE, 2.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_SURFACE, 0.004);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_COEFF, 1.25);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_SPEED, 0);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_DRAFT_FACTOR, 1.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_USER_WEIGHT, 75);
                mFECControl.controlEquipment(AntPlus.TRAINER_BIKE_WEIGHT, 9);
                //mFitContrib.lap(4);
                //mActivity.addLap();
                break;
            case REST2:
                btnAlert = STP_REST;
                stepDuration = getStoredValue("accelrestdur", ACCELREST_DEFAULT) * 1000;
                BreakPt2 = getStoredValue("BP2-watts", BP2_DEFAULT);
                targPwr1 = 0;
                targPwr2 = 0.25 * BreakPt2;
                mFECControl.controlEquipment(AntPlus.TRAINER_SLOPE, 0.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_SURFACE, 0.004);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_COEFF, 0.75);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_SPEED, 0);
                mFECControl.controlEquipment(AntPlus.TRAINER_WIND_DRAFT_FACTOR, 1.0);
                mFECControl.controlEquipment(AntPlus.TRAINER_USER_WEIGHT, 75);
                mFECControl.controlEquipment(AntPlus.TRAINER_BIKE_WEIGHT, 9);
                //mFitContrib.lap(0);
                //mActivity.addLap();
                break;
            case STOP:
                stopActivity();              // Stops the Activity
                mDelegate.startSaveTimer();  // Brings up the save screen
            default:
        } 
    }

//Activity Functions
    function createActivity() as Void {
        mActivity = ActivityRecording.createSession({
            :sport => Activity.SPORT_CYCLING,
            :subSport => Activity.SUB_SPORT_INDOOR_CYCLING,
            :name => "cycling"
        });
    }

    function startActivity() {
        mActivity.start();
        btnAlert = BTN_START;
    }

    function stopActivity() {
        //mFitContrib.lap(4);
        //mActivity.addLap();
        mActivity.stop();
        btnAlert = BTN_STOP;
    }

    function saveActivity() {
        mActivity.save();
        mActivity = null;
    }

    function discardActivity() {
        mActivity.discard();
        mActivity = null;
    }

    function isNullActivity() {
        if (mActivity == null) {
            return true;
        }
        else {
            return false;
        }
    }

    function isRecordingActivity() {
        return mActivity.isRecording();
    }

	function startFitContrib() {
		if (mFitContrib == null) {
			mFitContrib = new MO2FitContributor(mActivity);
		}
        setDeviceInfo();
    }

    function setDeviceInfo() {
		if (mFitContrib != null) {
			mFitContrib.setDeviceInfo();
		}
    }

    function manualLap() {
        incrementStep();
        /*if (is_lap_beg_marked && !is_lap_end_marked) {
            //mFitContrib.lap(0);
            //mActivity.addLap();
            is_lap_beg_marked = false;
            is_lap_end_marked = false;
        }*/
    }

//Alert Functions
    function clearBtnAlert() {
        btnAlert = BTN_NONE;
    }

}

