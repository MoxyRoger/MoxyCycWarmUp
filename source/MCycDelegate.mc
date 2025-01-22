import Toybox.Activity;
import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;

class MCycDelegate extends WatchUi.BehaviorDelegate {
    hidden var mIndex;
    hidden var mView;
    hidden var mMO2;
    hidden var mFEC;
    hidden var mViewAlert;

    hidden static var mTimer;

    function initialize(index, view, mo2, fec, alert) {
        BehaviorDelegate.initialize();
        mIndex = index;
        mView = view;
        mMO2 = mo2;
        mFEC = fec;
        mViewAlert = alert;
    }

    function nextPage(transition) {
        return switchToView((mIndex + 1) % 3, transition);
    }

    function prevPage(transition) {
        return switchToView((mIndex + 2) % 3, transition);
    }

    hidden function startSaveTimer() {
        mTimer = new Timer.Timer();
        mTimer.start(self.method(:promptToSave), 3000, false);
    }

    hidden function stopSaveTimer() {
        if (mTimer != null) {
            mTimer.stop();
            mTimer = null;
        }
    }

    function onKey(evt) as Boolean {
        var key = evt.getKey();
        if (key == WatchUi.KEY_DOWN) {
            nextPage(WatchUi.SLIDE_UP);
        }
        else if (key == WatchUi.KEY_UP) {
            prevPage(WatchUi.SLIDE_DOWN);
        }
        else if (key == WatchUi.KEY_LEFT) {
            prevPage(WatchUi.SLIDE_RIGHT);
        }
        else if (key == WatchUi.KEY_RIGHT) {
            nextPage(WatchUi.SLIDE_LEFT);
        }
        else if (key == G_Start_Button) {
            if (Application.getApp().isNullActivity()) {
                Application.getApp().createActivity(); // creates a new Activity in case of a discard or save
            }
            if (Application.getApp().isRecordingActivity()) {
                if(Application.getApp().stepIndex < COOLDOWN) {
                    Application.getApp().stopActivity();
                }
                else {
                    Application.getApp().stopActivity();
                    startSaveTimer();
                    WatchUi.requestUpdate();
                }
            }
            else {
                Application.getApp().startActivity();
                Application.getApp().startFitContrib();
                stopSaveTimer();
                WatchUi.requestUpdate();
            }
        }
        else if (key == G_Lap_Button) {
            if (Application.getApp().isNullActivity()) {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }
            else {
                var info = Activity.getActivityInfo();
                if (info.timerTime == null || info.timerTime == 0) {
                    Application.getApp().discardActivity();
                    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                }
                else if (Application.getApp().isRecordingActivity()) {
                    if (Application.getApp().btnAlert != BTN_LAP) {
                        Application.getApp().manualLap();
                    }
                    else {
                        Application.getApp().clearBtnAlert();
                    }
                    WatchUi.requestUpdate();
                }
                else {
                    promptToSave();
                }
            }
        }
        else if (key == WatchUi.KEY_ESC) {			//This case allows the Edge520 back button to exit the app before it's started.
        	if (Application.getApp().isNullActivity()) {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }
            else {
                var info = Activity.getActivityInfo();
                if (info.timerTime == null || info.timerTime == 0) {
                    Application.getApp().discardActivity();
                    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                }
            }
        }
        return true;
    }

    function onSwipe(evt) as Boolean {
        var swipe = evt.getDirection();
        if (swipe == WatchUi.SWIPE_RIGHT) {
            prevPage(WatchUi.SLIDE_RIGHT);
        }
        else if (swipe == WatchUi.SWIPE_LEFT) {
            nextPage(WatchUi.SLIDE_LEFT);
        }
        else if (swipe == WatchUi.SWIPE_UP) {
            nextPage(WatchUi.SLIDE_UP);
        }
        else if (swipe == WatchUi.SWIPE_DOWN) {
            prevPage(WatchUi.SLIDE_DOWN);
        }

        return true;
    }

    function onTap(evt) as Boolean {
        nextPage(WatchUi.SLIDE_LEFT);
        return true;
    }

	function onMenu() as Boolean {
		stopSaveTimer();

        var menu = new WatchUi.Menu();

        var ver = "Menu";

        menu.setTitle(ver);

        menu.addItem("Pair MO2 Sensor"     , :sensor);
        menu.addItem("Pair Trainer"        , :trainer);
        menu.addItem("Enter FTP"           , :ftp);
        menu.addItem("Sensor Location"     , :sensorLx);
        menu.addItem("Set Step Duration"   , :duration);
        menu.addItem("Set Load Step Size"  , :stepsize);
        menu.addItem("Set Initial Load"    , :initload);


        WatchUi.pushView(menu, new MCycMenuDelegate(mMO2, mFEC), WatchUi.SLIDE_IMMEDIATE);
        return true;
	}

    function promptToSave() as Void {
        stopSaveTimer();
        var menu = new SaveMenu(OPTIONS_SAVE_RESUME_DISCARD);
        var delegate = new SaveMenuDelegate(OPTIONS_SAVE_RESUME_DISCARD);
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
    }

    function switchToView(index, transition) {
        var view;
        if (0 == index) {
            view = new MCycView0(mMO2, mFEC, mViewAlert);
        }
        else if (1 == index) {
            view = new MCycView1(mMO2, mViewAlert);
        }
        else {
            view = new MCycView2(mMO2, mFEC, mViewAlert);
        }

        mIndex = index;

        WatchUi.switchToView(view, self, transition);
        WatchUi.requestUpdate();

        mView = view;

        return true;
    }

    function UpdateMO2(mo2) {
        mMO2 = mo2;
        // need to update in current view too?
    }

    function UpdateFEC(fec) {
        mFEC = fec;
    }
}
