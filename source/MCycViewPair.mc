using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class MCycViewPair extends Ui.View {
    hidden var mDevice;
    hidden var pairFlag;

    function initialize(device) {
        View.initialize();
        mDevice = device;
        pairFlag = false;
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        var cx = dc.getWidth() / 2;
        var cy = dc.getHeight() / 2;

        var status;
        if (mDevice.deviceNumber == 0 && !pairFlag) {
            status = "Searching...";
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        }
        else {
            status = "Paired to\nSensor " + mDevice.deviceNumber.toString();
            dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
            pairFlag = true;
        }

        dc.drawText(cx, cy, Gfx.FONT_LARGE,
                    status,
                    Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    }
}


class MCycPairDelegate extends Ui.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(evt) {
        if (evt.getKey() == Ui.KEY_ESC) {
            Ui.popView(SLIDE_UP);
        }
        else {
            return false;
        }

        return true;
    }
}