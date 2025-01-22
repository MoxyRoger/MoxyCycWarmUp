import Toybox.Application;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.FitContributor;

const SMO2_FIELD_ID = 0;
const THB_FIELD_ID = 1;
const DEVICE_INFO_ID = 2;
const INTENSITY_FIELD_ID = 3;

// format and units for displaying SmO2 data
const G_currentHemoPercentUnits = WatchUi.loadResource(Rez.Strings.smo2_units);
const G_currentHemoPercentLabel = WatchUi.loadResource(Rez.Strings.smo2_label);

// format and units for displaying THb data
const G_totalHemoConcentrationUnits = WatchUi.loadResource(Rez.Strings.thb_units);
const G_totalHemoConcentrationLabel = WatchUi.loadResource(Rez.Strings.thb_label);
const G_AppSensor = WatchUi.loadResource(Rez.Strings.AppSensor);

class MO2FitContributor {

    // FIT Contributions variables
    hidden var mSmO2 = null;
    hidden var mThb = null;
    hidden var mIntensity = null;
    hidden var mDeviceInfo = null;
    hidden var location;
    hidden var sensorId;

    // Constructor
    function initialize(activity) {
		location = Application.Storage.getValue("SensorLx");
		if (location == null) {
			location = Glocations.size()-1;
		}
        else if(location > Glocations.size()-1 or location < 0) {
            location = Glocations.size()-1;
        }
        sensorId = Application.Storage.getValue("SensorId");
        if(sensorId == null) {
            sensorId = 0;
        }

        var label = " Sensor " + sensorId + " on " + WatchUi.loadResource(Glocations[location]);
        mSmO2 = activity.createField(G_AppSensor + " " + G_currentHemoPercentLabel + label, SMO2_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, { :nativeNum=>57, :mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>G_currentHemoPercentUnits });
        mThb = activity.createField(G_AppSensor + " " + G_totalHemoConcentrationLabel + label, THB_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, { :nativeNum=>54, :mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>G_totalHemoConcentrationUnits });
		mIntensity = activity.createField("FIT_Lap_Intensity", INTENSITY_FIELD_ID, FitContributor.DATA_TYPE_UINT8, { :nativeNum=>23, :mesgType=>FitContributor.MESG_TYPE_LAP,  :units=>""});
        mDeviceInfo =  activity.createField("CIQ_device_info", DEVICE_INFO_ID, FitContributor.DATA_TYPE_UINT8, { :count=>8, :mesgType=>FitContributor.MESG_TYPE_SESSION });
        mSmO2.setData(0);
        mThb.setData(0);
        mIntensity.setData(4);
    }

    function compute(sensor) {
        if( sensor != null ) {
            var SmO2 = sensor.currentHemoPercent;
			var THb = sensor.totalHemoConcentration;
			if( SmO2 != null && THb != null) {
				mSmO2.setData(SmO2.toFloat());
        		mThb.setData(THb.toFloat());
        	}
        else {
        		mSmO2.setData(0);
        		mThb.setData(0);
        	}
        }
    }

    function lap(intensity) {
        mIntensity.setData(intensity);
    }
    
    function setDeviceInfo() {
        var deviceMfg = Application.Storage.getValue("DeviceMfg");
        if(deviceMfg == null) {
            deviceMfg = 0;
        }
        mDeviceInfo.setData([31,location,(sensorId),(sensorId >>  8),(sensorId >> 16),(sensorId >> 24),(deviceMfg),(deviceMfg >>  8)]);
    }

}