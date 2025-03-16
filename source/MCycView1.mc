using Toybox.Activity as Act;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using View1DeviceVars as device;

class MCycView1 extends Ui.View {
    hidden var mMO2;
    hidden var mViewAlert;
    hidden var mL1 = "SmO2";   
    hidden var mV1;
    hidden var mL2 = "THb"; 
    hidden var mV2;
    hidden var mL3 = "Heart Rate";   
    hidden var mV3;
    hidden var mL4 = "Cadence";
    hidden var mV4;

    function initialize(mo2, alert) {
        View.initialize();
        mMO2 = mo2;
        mViewAlert = alert;
    }

    function onLayout(dc) {
        //if ((device has :initVars) == true){
        //    device.initVars(dc);
        //}
    }

    function onUpdate(dc) {
        var SmO2_color = Gfx.COLOR_LT_GRAY;
        var THb_color = Gfx.COLOR_LT_GRAY;
		
        View.onUpdate(dc);

		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
		dc.clear();

		device.drawGrid(dc);

        if (G_Palette_Sz <= 8){
            SmO2_color = Gfx.COLOR_DK_GRAY;
            THb_color = Gfx.COLOR_DK_GRAY;
        }
        else {
            SmO2_color = Gfx.COLOR_LT_GRAY;
            THb_color = Gfx.COLOR_LT_GRAY;
        }
     
        if (mMO2._eventCount != null) {
            SmO2_color = Gfx.COLOR_BLACK;
            THb_color = Gfx.COLOR_BLACK;
        }
        if (mMO2.currentHemoPercent != null && mMO2.totalHemoConcentration != null) {
            mV1 = mMO2.currentHemoPercent.format("%.1f");
            mV2 = mMO2.totalHemoConcentration.format("%.2f");
        }
        else {
            mV1 = "--";
            mV2 = "--";
        }
        dc.setColor(SmO2_color, Gfx.COLOR_TRANSPARENT);
		dc.drawText(device.L1X, device.L1Y, device.LFont, mL1, device.LJust);
        dc.drawText(device.V1X, device.V1Y, device.VFont, mV1, device.VJust);
        dc.setColor(THb_color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(device.L2X, device.L2Y, device.LFont, mL2, device.LJust);
        dc.drawText(device.V2X, device.V2Y, device.VFont, mV2, device.VJust);


        var info = Act.getActivityInfo();

        if (info != null && info.currentHeartRate != null) {
            dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
            mV3 = info.currentHeartRate.format("%d");
        }
        else {
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
            mV3 = "--";
        }
            
        dc.drawText(device.L3X, device.L3Y, device.LFont, mL3, device.LJust);
        dc.drawText(device.V3X, device.V3Y, device.VFont, mV3, device.VJust);

        if (info != null && info.currentCadence != null) {
            dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
            mV4 = info.currentCadence.format("%d");	            
        }
        else {
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
            mV4 = "--";
        }
        dc.drawText(device.L4X, device.L4Y, device.LFont, mL4, device.LJust);
        dc.drawText(device.V4X, device.V4Y, device.VFont, mV4, device.VJust);         

        // Update Alerts
        mViewAlert.checkAlerts(dc);

        // hack to ensure that menus and progress bar are
        // rendered properly.
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
    }
}
