import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;

class MCycMenuDelegate extends WatchUi.MenuInputDelegate {
    var mMO2;
    var mFEC;

    function initialize(mo2, fec) {
        MenuInputDelegate.initialize();
        mMO2 = mo2;
        mFEC = fec;
    }

    function onMenuItem(item) {
        if (item == :sensor) {
            mMO2.goToSearch();
            WatchUi.pushView(new MCycViewPair(mMO2), new MCycPairDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
        else if (!IS_FEC_NATIVE && item == :trainer) {
            mFEC.goToSearch();
            WatchUi.pushView(new MCycViewPair(mFEC), new MCycPairDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :bp1) {
            var view = new AlertPicker(PICKER_TYPE_BP1);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_BP1, view), WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :bp2) {
            var view = new AlertPicker(PICKER_TYPE_BP2);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_BP2, view), WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :sensorLx) {
            var view = new AlertPicker(PICKER_TYPE_SENSORLX);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_SENSORLX, view),
                        WatchUi.SLIDE_IMMEDIATE);
        }     
        else if (item == :cvprep) {
            var view = new AlertPicker(PICKER_TYPE_CVPREP);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_CVPREP, view),
                        WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :cvrest) {
            var view = new AlertPicker(PICKER_TYPE_CVREST);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_CVREST, view),
                        WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :accel) {
            var view = new AlertPicker(PICKER_TYPE_ACCEL);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_ACCEL, view),
                        WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :accelrest) {
            var view = new AlertPicker(PICKER_TYPE_ACCELREST);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_ACCELREST, view),
                        WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :numaccel) {
            var view = new AlertPicker(PICKER_TYPE_NUMACCEL);
            WatchUi.pushView(view, new AlertPickerDelegate(PICKER_TYPE_NUMACCEL, view),
                        WatchUi.SLIDE_IMMEDIATE);
        }
        
    }
}


class Alert extends WatchUi.View {
    hidden var mTimer;
    hidden var mTimeout;
    hidden var mText;

    class Delegate extends WatchUi.InputDelegate {
        hidden var mView;

        function initialize(view) {
            InputDelegate.initialize();
            mView = view;
        }

        function onKey(evt) as Boolean {
            mView.dismiss();
            return true;
        }

        function onTap(evt) as Boolean {
            mView.dismiss();
            return true;
        }
    }

    static function show(text) {
        new Alert(text);
    }

    function initialize(text) {
        View.initialize();
        mText = text;
        mTimeout = 2000;
        mTimer = new Timer.Timer();
        WatchUi.pushView(self, new Delegate(self), WatchUi.SLIDE_IMMEDIATE);
    }

    function onShow() {
        mTimer.start(method(:dismiss), mTimeout, false);
    }

    function onHide() {
        mTimer.stop();
    }

    function onUpdate(dc) {
        var tWidth  = dc.getTextWidthInPixels(mText, Graphics.FONT_MEDIUM);
        var tHeight = dc.getFontHeight(Graphics.FONT_MEDIUM);

        var bWidth  = tWidth + 14;
        var bHeight = tHeight + 14;

        var bX = (dc.getWidth() - bWidth) / 2;
        var bY = (dc.getHeight() - bHeight) / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillRectangle(bX, bY, bWidth, bHeight);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        for (var i = 0; i < 2; ++i) {
            bX += i;
            bY += i;
            bWidth -= (2 * i);
            bHeight -= (2 * i);

            dc.drawRectangle(bX, bY, bWidth, bHeight);
        }

        var tX = dc.getWidth() / 2;
        var tY = (dc.getHeight() - tHeight) / 2;

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(tX, tY, Graphics.FONT_MEDIUM, mText, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function dismiss() {
        WatchUi.popView(SLIDE_IMMEDIATE);
    }
}

