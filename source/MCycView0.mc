using Toybox.Activity as Act;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using View0DeviceVars as device;

class MCycView0 extends Ui.View {
    hidden var mMO2;
    hidden var mFEC;
    hidden var mViewAlert;

    hidden var mTime;
    hidden var mVersion;
    hidden var mVerShowTime;
    hidden var mHasPower;
    hidden var mIndRad = 7;

    function initialize(mo2, fec, alert) {
        View.initialize();
        mMO2 = mo2;
        mFEC = fec;
        mViewAlert = alert;
        if(Act.getActivityInfo() has :currentPower) {
    		mHasPower = true;
    	}
    	else {
    		mHasPower = false;
    	}  	
    }

    function onLayout(dc) {
        //if ((device has :initVars) == true){
        //    device.initVars(dc);
        //}
    }

    function onShow() {
        mVersion = Ui.loadResource(Rez.Strings.AppName);
        mVersion += " ";
        mVersion += Ui.loadResource(Rez.Strings.AppVersion);
        mVerShowTime = Sys.getTimer();
    }

    function onUpdate(dc) {
		View.onUpdate(dc);

		var width = dc.getWidth();

		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
		dc.clear();

		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, device.LineY, width, device.LineH);
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		dc.drawCircle(device.MO2X, device.IndicatorY, mIndRad);
		dc.drawText(device.MO2X, device.LabelY, device.LabelFont, "MO2", Gfx.TEXT_JUSTIFY_CENTER );
		dc.drawCircle(device.HRX, device.IndicatorY, mIndRad);
		dc.drawText(device.HRX, device.LabelY, device.LabelFont, "HR", Gfx.TEXT_JUSTIFY_CENTER );
		dc.drawCircle(device.FECX, device.IndicatorY, mIndRad);
		dc.drawText(device.FECX, device.LabelY, device.LabelFont, "FEC", Gfx.TEXT_JUSTIFY_CENTER );
		dc.drawCircle(device.PowerX, device.IndicatorY, mIndRad);
		dc.drawText(device.PowerX, device.LabelY, device.LabelFont, "PWR", Gfx.TEXT_JUSTIFY_CENTER );

		var elapsed = Sys.getTimer() - mVerShowTime;
        if (2500 > elapsed) {
			dc.drawText(device.VersionX, device.VersionY, device.VersionFont, mVersion, device.VersionJ);
        }

		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
        var info = Act.getActivityInfo();

        var time = 0;
        if (info != null) {
            if (info.timerTime != null) {
                time = info.timerTime / 1000;
            }
            if (info.currentHeartRate != null) {
            	dc.fillCircle(device.HRX, device.IndicatorY, mIndRad-1);
            }
            if (mFEC.is_first_msg == false) {
            	dc.fillCircle(device.FECX, device.IndicatorY, mIndRad-1);
            }
            if (mHasPower and info.currentPower != null) {
            	dc.fillCircle(device.PowerX, device.IndicatorY, mIndRad-1);
            }
        }
        if (mMO2._eventCount != null)
        {
        	dc.fillCircle(device.MO2X, device.IndicatorY, mIndRad-1);
        }
        
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        mTime = format_elapsed_time(time);
        dc.drawText(device.TimeX, device.TimeY, device.TimeFont, mTime, Gfx.TEXT_JUSTIFY_CENTER); 

        // Update Alerts
        mViewAlert.checkAlerts(dc);

        // hack to ensure that menus and progress bar are
        // rendered properly.
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
    }
}
