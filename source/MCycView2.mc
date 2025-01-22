using Toybox.Activity as Act;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using View2DeviceVars as device;

class MCycView2 extends Ui.View {
    hidden var mSensor;
    hidden var mFEC;
    hidden var mViewAlert;
    hidden var mV1;
    hidden var mL2 = "Time"; 
    hidden var mV2;
    hidden var mL3 = " ";   
    hidden var mV3;
    hidden var mL4 = " ";
    hidden var mV4;
    hidden var stepIndex;

    function initialize(sensor, fec, alert) {
        View.initialize();
        mSensor = sensor;
        mFEC = fec;
        mViewAlert = alert;
    }

    function onLayout(dc) {
        //if ((device has :initVars) == true){
        //    device.initVars(dc);
        //}
    }

    function onUpdate(dc) {
		View.onUpdate(dc);
        stepIndex = Application.getApp().stepIndex;
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
		dc.clear();

		device.drawGrid(dc);

        var info = Act.getActivityInfo();

        if (G_Palette_Sz <= 8){
            dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        }
        else{
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);    
        }

        switch(stepIndex) {
            case STEP_INIT:
                mV1 = " ";
                break;
            case COUNTDOWN:
                mV1 = "Get Ready";
                break;
            case COUNTDOWN2:
                mV1 = "Get Ready";
                break;
            case WARM1:
                if ((Sys.getTimer() / 1000) & 2){
                    mV1 = "Warm Up";
                }
                else{
                    mV1 = "30% of FTP";
                }
                break;
            case WARM2:
                if ((Sys.getTimer() / 1000) & 2){
                    mV1 = "Warm Up";
                }
                else{
                    mV1 = "45% of FTP";
                }
                break;
            case WARM3:
                if ((Sys.getTimer() / 1000) & 2){
                    mV1 = "Warm Up";
                }
                else{
                    mV1 = "60% of FTP";
                }
                break;
            case REST1:
                mV1 = "STOP";
                break;
            case STEPTEST:
                mV1 = "Step Test";
                break;
            case COOLDOWN:
                mV1 = "Cool Down";
                break;
        }

        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(device.V1X, device.V1Y, device.VTxtFont, mV1, device.VJust);

        mV2 = "";

        if (G_Palette_Sz <= 8){
            dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        }
        else{
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);    
        }

        if (info != null) {
			if (info.timerTime != null) {
                mV2 = format_elapsed_time((App.getApp().stepDuration - info.timerTime + App.getApp().stepStartTime)/1000);
                dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
            }
        }
        dc.drawText(device.L2X, device.L2Y, device.LFont, mL2, device.LJust);
        dc.drawText(device.V2X, device.V2Y, device.VNumFont, mV2, device.VJust);
        
        mV3 = "--";
        if (G_Palette_Sz <= 8){
            dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        }
        else{
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);    
        }

        if (info != null) {
            if (info.currentPower != null) {
                mL3 = "Current Power";
                mV3 = info.currentPower.format("%d");
                dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
            }
        }

        dc.drawText(device.L3X, device.L3Y, device.LFont, mL3, device.LJust);
        dc.drawText(device.V3X, device.V3Y, device.VNumFont, mV3, device.VJust);

        mL4 = "Target Power";
        mV4 = Application.getApp().targetPower.format("%.0f");
        
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(device.L4X, device.L4Y, device.LFont, mL4, device.LJust);
    	dc.drawText(device.V4X, device.V4Y, device.VNumFont, mV4, device.VJust);

        mViewAlert.checkAlerts(dc);

        // hack to ensure that menus and progress bar are
        // rendered properly.
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
    }  
}
