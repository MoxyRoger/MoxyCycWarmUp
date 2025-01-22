using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

enum {
    PICKER_TYPE_FTP,
    PICKER_TYPE_SENSORLX,
    PICKER_TYPE_DURATION,
    PICKER_TYPE_STEPSIZE,
    PICKER_TYPE_INITLOAD
}


var Glocations = [
    Rez.Strings.left_leg,
    Rez.Strings.left_calf,
    Rez.Strings.left_shin,
    Rez.Strings.left_hamstring,
    Rez.Strings.left_quad,
    Rez.Strings.left_glute,
    Rez.Strings.right_leg,
    Rez.Strings.right_calf,
    Rez.Strings.right_shin,
    Rez.Strings.right_hamstring,
    Rez.Strings.right_quad,
    Rez.Strings.right_glute,
    Rez.Strings.torso_back,
    Rez.Strings.left_lower_back,
    Rez.Strings.left_upper_back,
    Rez.Strings.right_lower_back,
    Rez.Strings.right_upper_back,
    Rez.Strings.torso_front,
    Rez.Strings.left_abdomen,
    Rez.Strings.left_chest,
    Rez.Strings.right_abdomen,
    Rez.Strings.right_chest,
    Rez.Strings.left_arm,
    Rez.Strings.left_shoulder,
    Rez.Strings.left_bicep,
    Rez.Strings.left_tricep,
    Rez.Strings.left_brachioradialis,
    Rez.Strings.left_forearm_extensors,
    Rez.Strings.right_arm,
    Rez.Strings.right_shoulder,
    Rez.Strings.right_bicep,
    Rez.Strings.right_tricep,
    Rez.Strings.right_brachioradialis,
    Rez.Strings.right_forearm_extensors,
    Rez.Strings.neck,
    Rez.Strings.throat,
    Rez.Strings.none
];  

class AlertPicker extends Ui.View {
    var mType;
    var mText;
    var mSetPoint;
    var width = 0;
    var height = 0;

    function initialize(type) {
        View.initialize();
        mType = type;

        if (mType == PICKER_TYPE_FTP) {
            mText = "FTP(watts)";
        }
        else if (mType == PICKER_TYPE_SENSORLX) {
            mText = "Sensor Loc";
        }
        else if (mType == PICKER_TYPE_DURATION) {
            mText = "Step Duration (Seconds)";
        }
        else if (mType == PICKER_TYPE_STEPSIZE) {
            mText = "Load Step Size (watts)";
        }
        else if (mType == PICKER_TYPE_INITLOAD) {
            mText = "Inital Load (watts)";
        }
    }

    function onUpdate(dc) {
        width = dc.getWidth();
        height = dc.getHeight();
        var txtFont = Gfx.FONT_MEDIUM;
        var txtHeight = dc.getFontHeight(txtFont);
        var numFont = Gfx.FONT_NUMBER_HOT;
        var numHeight = dc.getFontHeight(numFont);
        var margin = 10;
        var numCenter = height / 2 + txtHeight / 2;
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width / 2, margin, txtFont, mText, Gfx.TEXT_JUSTIFY_CENTER);

        var dispval=0;
        if (mType == PICKER_TYPE_FTP) {
            mSetPoint = App.Storage.getValue("FTP-watts");
            if (mSetPoint == null) {
                mSetPoint = FTP_DEFAULT;
            }
            dispval = mSetPoint.format("%d");
        }
        else if (mType == PICKER_TYPE_SENSORLX) {
            mSetPoint = App.Storage.getValue("SensorLx");
            if (mSetPoint == null) {
            	mSetPoint = Glocations.size() - 1;
            }
            else if (mSetPoint > Glocations.size() - 1 or mSetPoint < 0) {
                mSetPoint = Glocations.size() - 1;
            }
            numFont = Gfx.FONT_MEDIUM;
            dispval = Ui.loadResource(Glocations[mSetPoint]);
        }
        if (mType == PICKER_TYPE_DURATION) {
            mSetPoint = App.Storage.getValue("duration");
            if (mSetPoint == null) {
                mSetPoint = DURATION_DEFAULT;
            }
            dispval = mSetPoint.format("%d");
        }
        if (mType == PICKER_TYPE_STEPSIZE) {
            mSetPoint = App.Storage.getValue("stepsize");
            if (mSetPoint == null) {
                mSetPoint = STEPSIZE_DEFAULT;
            }
            dispval = mSetPoint.format("%d");
        }
        if (mType == PICKER_TYPE_INITLOAD) {
            mSetPoint = App.Storage.getValue("initload");
            if (mSetPoint == null) {
                mSetPoint = INITLOAD_DEFAULT;
            }
            dispval = mSetPoint.format("%d");
        }

        var numWidth = dc.getTextWidthInPixels(dispval, numFont);
        var rectTop = numCenter - numHeight / 2 - margin / 2;
        dc.drawRectangle((width - numWidth - margin) / 2, rectTop, numWidth + margin,
                         numHeight + margin);
        dc.drawRectangle((width - numWidth - margin) / 2 - 1, rectTop - 1,
                         numWidth + margin + 2, numHeight + margin + 2);

        var polygon = [ [width / 2, rectTop - 11],
                        [width / 2 - 8, rectTop - 3],
                        [width / 2 + 8, rectTop - 3] ];
        dc.fillPolygon(polygon);

        polygon = [ [width / 2, rectTop + numHeight + margin + 11],
                    [width / 2 - 8, rectTop + numHeight + margin + 3],
                    [width / 2 + 8, rectTop + numHeight + margin + 3] ];
        dc.fillPolygon(polygon);

        dc.drawText(width / 2, numCenter - numHeight / 2, numFont,
                    dispval, Gfx.TEXT_JUSTIFY_CENTER);

        polygon = [ [0 + width - 50, 0 + numCenter],
                    [5 + width - 50, -5 + numCenter],
                    [13 + width - 50, 3 + numCenter],
                    [31 + width - 50, -15 + numCenter],
                    [36 + width - 50, -10 + numCenter],
                    [13 + width - 50, 13 + numCenter] ];
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        dc.fillPolygon(polygon);
    }
}

class AlertPickerDelegate extends Ui.InputDelegate {
    var mType;
    var mView;
    var mSetPoint;
    var max;
    var min;
    var incr;

    function initialize(type, view) {
        InputDelegate.initialize();
        mView = view;
        mType = type;

        if (mType == PICKER_TYPE_FTP) {
            mSetPoint = App.Storage.getValue("FTP-watts");
            if (mSetPoint == null) {
                mSetPoint = FTP_DEFAULT;
            }
            max = 600;
            min = 25;
            incr = 1;
        }
        else if (mType == PICKER_TYPE_SENSORLX) {
            mSetPoint = App.Storage.getValue("SensorLx");
            if (mSetPoint == null) {
            	mSetPoint = Glocations.size() - 1;
            }
            else if (mSetPoint > Glocations.size() - 1 or mSetPoint < 0) {
                mSetPoint = Glocations.size() - 1;
            }
            max = Glocations.size() - 1;
            min = 0;
            incr = 1;
        }
        if (mType == PICKER_TYPE_DURATION) {
            mSetPoint = App.Storage.getValue("duration");
            if (mSetPoint == null) {
                mSetPoint = DURATION_DEFAULT;
            }
            max = 600;
            min = 60;
            incr = 1;
        }
        if (mType == PICKER_TYPE_STEPSIZE) {
            mSetPoint = App.Storage.getValue("stepsize");
            if (mSetPoint == null) {
                mSetPoint = STEPSIZE_DEFAULT;
            }
            max = 250;
            min = 1;
            incr = 1;
        }
        if (mType == PICKER_TYPE_INITLOAD) {
            mSetPoint = App.Storage.getValue("initload");
            if (mSetPoint == null) {
                mSetPoint = INITLOAD_DEFAULT;
            }
            max = 600;
            min = 1;
            incr = 1;
        }
        Ui.requestUpdate();
    }

    function onKey(evt) {
        if (evt.getKey() == Ui.KEY_DOWN) {
            increment(-incr);
        }
        else if (evt.getKey() == Ui.KEY_UP) {
            increment(incr);
        }
        else if (evt.getKey() == Ui.KEY_ENTER) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        }
        else if (evt.getKey() == Ui.KEY_ESC) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        }

        return true;
    }

    function onTap(evt) {
        var coord = evt.getCoordinates();
        var width = mView.width;
        var height = mView.height;

        if (coord[0] > 2 * width / 3) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        }
        else if (coord[1] < height / 2) {
            increment(incr);
        }
        else {
            increment(-incr);
        }

        return true;
    }

    hidden function increment(inc) {
        mSetPoint = mSetPoint + inc;
        if (max < mSetPoint) {
            mSetPoint = max;
        }
        else if (mSetPoint < min) {
            mSetPoint = min;
        }

        if (mType == PICKER_TYPE_FTP) {
            App.Storage.setValue("FTP-watts", mSetPoint);
        }
        else if (mType == PICKER_TYPE_SENSORLX) {
			var val = mSetPoint;
        	if (val == Glocations.size() - 1) {
        		val = 255;
        	}
            App.Storage.setValue("SensorLx", val);
            App.getApp().setDeviceInfo();
        }
        if (mType == PICKER_TYPE_DURATION) {
            App.Storage.setValue("duration", mSetPoint);
        }
        if (mType == PICKER_TYPE_STEPSIZE) {
            App.Storage.setValue("stepsize", mSetPoint);
        }
        if (mType == PICKER_TYPE_INITLOAD) {
            App.Storage.setValue("initload", mSetPoint);
        }

        Ui.requestUpdate();
    }
}
