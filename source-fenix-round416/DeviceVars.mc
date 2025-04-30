using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 208;
    var TitleY = 55;
    var LineY = 210;
    var LineH = 2;
    var LabelY = 225;
    var IndicatorY = 280;
    var MO2X = 73;
    var HRX = 163;
    var FECX = 253;
    var PowerX = 343;
    var VersionX = 208;
    var VersionY = 300;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TitleFont = Gfx.FONT_MEDIUM;
    var LabelFont = Gfx.FONT_XTINY;
    var VersionFont = Gfx.FONT_XTINY;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 147, width, 2);
		dc.fillRectangle(0, 267, width, 2);
		dc.fillRectangle(207, 147, 2, 122);
	}
	
	var L1X = 208;
	var L2X = 208;
	var L3X = 303;
	var L4X = 113;
	var L1Y = 20;
	var L2Y = 370;
	var L3Y = 148;
	var L4Y = 148;
	var V1X = 208;
	var V2X = 208;
	var V3X = 303;
	var V4X = 113;
	var V1Y = 95;
	var V2Y = 320;
	var V3Y = 223;
	var V4Y = 223;
	var LFont = Gfx.FONT_XTINY;
	var VFont = Gfx.FONT_NUMBER_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(60, 180, 293, 2);
		dc.fillRectangle(0, 293, width, 2);
	}
	
	var L1X = 207; // Timer
	var L1Y = 183;
	var V1X = 207;
	var V1Y = 254;

	var L2X = null; // Heart Rate
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 207; // SmO2
	var L3Y = 295;
	var V3X = 207;
	var V3Y = 365;  

	var L4X = 207; // Power
	var L4Y = 70;
	var V4X = 207;
	var V4Y = 140;

	var Targ1X = null; // Targets
	var Targ2X = null;
	var Targ1Y = null;
	var Targ2Y = null;
	var TargAng1 = 50;
	var TargAng2 = 130;
	
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_MEDIUM;
	var VTxtFont = Gfx.FONT_LARGE;
	var TargFont = Gfx.FONT_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;

	var meterX = 207; // Meter
	var meterY = 207;
	var meterR = 200;
	var meterT = 40;
}