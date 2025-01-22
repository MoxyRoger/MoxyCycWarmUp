import Toybox.Activity;
import Toybox.ActivityRecording;
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
    COUNTDOWN2,
    WARM1,
    WARM2,
    WARM3,
    REST1,
    STEPTEST,
    COOLDOWN
}

enum{
    SEND_INIT,
    SEND_USER,
    CONF_USER,
    SEND_TARGPWR,
    CONF_TARGPWR,
    SEND_WINDRESIST,
    CONF_WINDRESIST,
    SEND_TRACKRESIST,
    CONF_TRACKRESIST
}

const FTP_DEFAULT = 150;
const DURATION_DEFAULT = 60;
const STEPSIZE_DEFAULT = 20;
const INITLOAD_DEFAULT = 60;

class MoxyStepTest extends Application.AppBase {
    hidden var mTimer;
    hidden var mMO2;
    hidden var mFEC;
    hidden var mViewAlert;
    hidden var mDelegate;
    hidden var mActivity;
    hidden var mFitContrib;
    var lapStartDist = 0;
    var lapStartTime = 0;
    var lapPrevDist;
    var lapPrevTime;
    var btnAlert;
    var targetPower = 0;
    var stepStartTime = 0;
    var stepIndex = STEP_INIT;
    var stepDuration = 1000;
    var loadStep = 0;
    var is_lap_beg_marked = false;
    var is_lap_end_marked = false;

    function initialize() {
        AppBase.initialize();
        mTimer = new Timer.Timer();
        btnAlert = BTN_NONE;
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        mMO2 = new MO2Sensor();
        mFEC = new FECTrainer();
        mViewAlert = new ViewAlert(mMO2);

        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE,
                                  Sensor.SENSOR_BIKECADENCE,
                                  Sensor.SENSOR_BIKESPEED,
                                  Sensor.SENSOR_BIKEPOWER]);

        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS,method(:onPositionCallback));

		createActivity();
        mTimer.start(self.method(:onTimerCallback), 1000, true);
    }

    function onStop(state) {
        mTimer.stop();

        // disable events
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPositionCallback));

        // disable sensors
        Sensor.setEnabledSensors([]);

        // close the MO2 sensor
        mMO2.release();
        mFEC.release();
    }

    function getInitialView() {
        var view = new MCycView0(mMO2, mFEC, mViewAlert);
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
        checkStepTime();
        WatchUi.requestUpdate();
    }

    function checkStepTime() {
        var info = Activity.getActivityInfo();
        if (info != null) {
            if (info.timerTime != null){
                if(stepIndex == STEPTEST){
                    if (!is_lap_beg_marked && (info.timerTime - stepStartTime > 50*1000)) {
                        mFitContrib.lap(4);
                        mActivity.addLap();
                        is_lap_beg_marked = true;
                    }
                    if (!is_lap_end_marked && (info.timerTime - stepStartTime > (stepDuration - 3000))) {
                        mFitContrib.lap(0);
                        mActivity.addLap();
                        is_lap_end_marked = true;
                    }
                }
                if (info.timerTime - stepStartTime > (stepDuration - 500)) {
                    incrementStep();
                    is_lap_beg_marked = false;
                    is_lap_end_marked = false;
                }
            }
        }
    }

    function incrementStep() {
        var info = Activity.getActivityInfo();
        var ftp;
        var stepsize;
        var initload;
        if(stepIndex < STEPTEST) {
            stepIndex = stepIndex + 1;
        }
        stepStartTime = info.timerTime;
        switch(stepIndex) {
            case COUNTDOWN:
                btnAlert = BTN_NONE;
                stepDuration = 3 * 1000;
                targetPower = 1;
                mFEC.ackSequence = SEND_USER;
                break;
            case COUNTDOWN2:
                btnAlert = BTN_NONE;
                stepDuration = 3 * 1000;
                targetPower = 1;
                mFEC.ackSequence = SEND_WINDRESIST;
                break;
            case WARM1:
                btnAlert = STP_WARM;
                stepDuration = 180 * 1000;
                ftp = Storage.getValue("FTP-watts");
                if (ftp == null) {
                    ftp = FTP_DEFAULT;
                }
                targetPower = 0.30 * ftp;
                mFEC.ackSequence = SEND_TARGPWR;;
                break;
            case WARM2:
                btnAlert = STP_WARM;
                stepDuration = 180 * 1000;
                ftp = Storage.getValue("FTP-watts");
                if (ftp == null) {
                    ftp = FTP_DEFAULT;
                }
                targetPower = 0.45 * ftp;
                mFEC.ackSequence = SEND_TARGPWR;
                break;
            case WARM3:
                btnAlert = STP_WARM;
                stepDuration = 180 * 1000;
                ftp = Storage.getValue("FTP-watts");
                if (ftp == null) {
                    ftp = FTP_DEFAULT;
                }
                targetPower = 0.60 * ftp;
                mFEC.ackSequence = SEND_TARGPWR;
                break;
            case REST1:
                btnAlert = STP_REST;
                stepDuration = 60 * 1000;
                targetPower = 0;
                mFEC.ackSequence = SEND_TARGPWR;
                break;
            case STEPTEST:
                btnAlert = STP_STEP;
                stepDuration = Storage.getValue("duration");
                if (stepDuration == null) {
                    stepDuration = DURATION_DEFAULT;
                }
                stepDuration = stepDuration * 1000;
                initload = Storage.getValue("initload");
                if (initload == null) {
                    initload = INITLOAD_DEFAULT;
                }
                stepsize = Storage.getValue("stepsize");
                if (stepsize == null) {
                    stepsize = STEPSIZE_DEFAULT;
                }
                targetPower = stepsize * loadStep + initload;
                loadStep = loadStep + 1;
                mFEC.ackSequence = SEND_TARGPWR;
                break;
            case COOLDOWN:
                btnAlert = STP_COOL;
                stepDuration = 360*1000;
                targetPower = 60;
                mFEC.ackSequence = SEND_TARGPWR;
                break;
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
        // set the start alert
    }

    function stopActivity() {
        if(stepIndex < COOLDOWN) {      // make it so the first stop goes to cooldown.
            if (is_lap_beg_marked && !is_lap_end_marked) {
                mFitContrib.lap(0);
                mActivity.addLap();
                is_lap_beg_marked = false;
            }
            stepIndex = COOLDOWN;
            incrementStep();
        }
        else {
            mFitContrib.lap(4);
            mActivity.addLap();
            mActivity.stop();
            btnAlert = BTN_STOP;
        }
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
        if (is_lap_beg_marked && !is_lap_end_marked) {
            mFitContrib.lap(0);
            mActivity.addLap();
            is_lap_beg_marked = false;
            is_lap_end_marked = false;
        }
    }

//Alert Functions
    function clearBtnAlert() {
        btnAlert = BTN_NONE;
    }

}

