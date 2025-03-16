using Toybox.Activity as Act;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using View2DeviceVars as device;

class MCycView2 extends Ui.View {
    hidden var mMO2;
    hidden var mViewAlert;
    hidden var mL1 = "";
    hidden var mV1;
    hidden var mL2 = "Heart Rate"; 
    hidden var mV2;
    hidden var mL3 = "SmO2";   
    hidden var mV3;
    hidden var mL4 = "Power";   
    hidden var mV4;
    hidden var mTarg1;
    hidden var mTarg2;
    hidden var stepIndex;
    hidden var mGray;

    function initialize(mo2, alert) {
        View.initialize();
        mMO2 = mo2;
        mViewAlert = alert;
    }

    function onLayout(dc) {
    }

    function onUpdate(dc) {
		View.onUpdate(dc);
        stepIndex = Application.getApp().stepIndex;
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
		dc.clear();

		device.drawGrid(dc);
        var info = Act.getActivityInfo();
        if (G_Palette_Sz <= 8){              // for devices with only 8 colors, need to use DK_GRAY
            mGray = Gfx.COLOR_DK_GRAY;
        }
        else{
            mGray = Gfx.COLOR_LT_GRAY;    
        }

        // Field 1 = Timer
        dc.setColor(mGray, Gfx.COLOR_TRANSPARENT);    
        switch(stepIndex) {
            case STEP_INIT:
                mL1 = " ";
                break;
            case COUNTDOWN:
                mL1 = "Get Ready";
                break;
            case CV1:
                mL1 = "CV Prep 1";
                break;
            case CV2:
                mL1 = "CV Prep 2";
                break;
            case REST1:
                mL1 = "Rest";
                break;
            case ACCELS:
                mL1 = "Accelerator " + App.getApp().accelerator;
                break;
            case REST2:
                mL1 = "Rest";
                break;
        }
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(device.L1X, device.L1Y, device.LFont, mL1, device.LJust);
        mV1 = 0;
        if (info != null) {
			if (info.timerTime != null) {
                if (info.timerTime > 0){
                    mV1 = format_elapsed_time((App.getApp().stepDuration - info.timerTime + App.getApp().stepStartTime)/1000);
                    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
                    dc.drawText(device.V1X, device.V1Y, device.VNumFont, mV1, device.VJust);
                }
            }
        }

        // Field 2
        if (device.L2X != null){
            mV2 = "--";
            dc.setColor(mGray, Gfx.COLOR_TRANSPARENT);
            if (info != null) {
                if (info.currentHeartRate != null) {
                    mV2 = info.currentHeartRate.format("%d");;
                    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
                }
            }
            dc.drawText(device.L2X, device.L2Y, device.LFont, mL2, device.LJust);
            dc.drawText(device.V2X, device.V2Y, device.VNumFont, mV2, device.VJust);
        }

        // Field 3
        if (device.L3X != null) {
            mV3 = "--";
            if (G_Palette_Sz <= 8){
                dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
            }
            else{
                dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);    
            }
            if (info != null) {
                if (mMO2.currentHemoPercent != null && mMO2.totalHemoConcentration != null) {
                    mV3 = mMO2.currentHemoPercent.format("%.0f");
                    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
                }
            }
            dc.drawText(device.L3X, device.L3Y, device.LFont, mL3, device.LJust);
            dc.drawText(device.V3X, device.V3Y, device.VNumFont, mV3, device.VJust);
        }

        // Field 4
        mV4 = "--";
        dc.setColor(mGray, Gfx.COLOR_TRANSPARENT);
        if (App.getApp().pwrSmooth != null) {
            mV4 = App.getApp().pwrSmooth.format("%d");
            dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        }
        dc.drawText(device.L4X, device.L4Y, device.LFont, mL4, device.LJust);
    	dc.drawText(device.V4X, device.V4Y, device.VNumFont, mV4, device.VJust);

        // Meter Display
        var value = 0;
        //dc.setPenWidth(device.meterR);
        dc.setPenWidth(device.meterT);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED);
        dc.drawArc(device.meterX, device.meterY, device.meterR-device.meterT/2, Gfx.ARC_COUNTER_CLOCKWISE, 0, device.TargAng1);
        dc.setPenWidth(1.2*device.meterT);
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
        dc.drawArc(device.meterX, device.meterY, device.meterR-device.meterT/1.67, Gfx.ARC_COUNTER_CLOCKWISE, device.TargAng1, device.TargAng2);
        dc.setPenWidth(device.meterT);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED);
        dc.drawArc(device.meterX, device.meterY, device.meterR-device.meterT/2, Gfx.ARC_COUNTER_CLOCKWISE, device.TargAng2, 180);

        mTarg1 = App.getApp().targPwr1;
        mTarg2 = App.getApp().targPwr2;
        if (mTarg2 - mTarg1 > 0) {
            if (App.getApp().pwrSmooth != null) {
                value = ((App.getApp().pwrSmooth-mTarg1)*((device.TargAng2 - device.TargAng1)/(mTarg2-mTarg1)) + device.TargAng1)/180;
            }
            if (value < 0) {
                value = 0;
            }
            if (value > 1) {
                value = 1;
            }
            dc.setPenWidth(1);
            if (value != null) {
                /*var points = [
                                [ device.meterR - 1.5*device.meterT,  5 ],
                                [ device.meterR - 5,                  5 ],
                                [ device.meterR,                      0 ],
                                [ device.meterR - 5,                 -5 ],
                                [ device.meterR - 1.5*device.meterT, -5 ],
                                [ device.meterR - 1.5*device.meterT,  5 ]
                            ];*/
                
                var points = [
                                [ device.meterR - 1.30 * device.meterT,  0.50 * device.meterT ],
                                [ device.meterR - 0.20 * device.meterT,  0.00                 ],
                                [ device.meterR - 1.30 * device.meterT, -0.50 * device.meterT ],
                                [ device.meterR - 1.30 * device.meterT,  0.50 * device.meterT ],
                            ];
                var sin = Math.sin(value * Math.PI);
                var cos = Math.cos(value * Math.PI);

                for (var i = 0; i < points.size(); ++i) {
                    var x = (points[i][0] * cos) - (points[i][1] * sin);
                    var y = (points[i][0] * sin) + (points[i][1] * cos);
                    points[i][0] = device.meterX - x;
                    points[i][1] = device.meterY - y;
                }

                dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
                dc.fillPolygon(points);






                //dc.fillCircle(device.meterX, device.meterY, py);
            }
            dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
            if (device.Targ1X != null) {
                dc.drawText(device.Targ1X, device.Targ1Y, device.TargFont, mTarg1.format("%d"), device.VJust);
                dc.drawText(device.Targ2X, device.Targ2Y, device.TargFont, mTarg2.format("%d"), device.VJust);
            }

        }

        mViewAlert.checkAlerts(dc);

        // hack to ensure that menus and progress bar are
        // rendered properly.
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
    }  
}
