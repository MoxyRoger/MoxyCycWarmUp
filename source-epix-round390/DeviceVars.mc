using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 195;
    var TitleY = 50;
    var LineY = 194;
    var LineH = 2;
    var LabelY = 215;
    var IndicatorY = 270;
    var MO2X = 60;
    var HRX = 150;
    var FECX = 240;
    var PowerX = 330;
    var VersionX = 195;
    var VersionY = 300;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TitleFont = Gfx.FONT_LARGE;
    var LabelFont = Gfx.FONT_SMALL;
    var VersionFont = Gfx.FONT_XTINY;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 134, width, 2);
		dc.fillRectangle(0, 254, width, 2);
		dc.fillRectangle(194, 134, 2, 122);
	}
	
	var L1X = 194;
	var L2X = 194;
	var L3X = 290;
	var L4X = 100;
	var L1Y = 20;
	var L2Y = 340;
	var L3Y = 140;
	var L4Y = 140;
	var V1X = 194;
	var V2X = 194;
	var V3X = 290;
	var V4X = 100;
	var V1Y = 87;
	var V2Y = 305;
	var V3Y = 210;
	var V4Y = 210;
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
		dc.fillRectangle(60, 170, 270, 2);
		dc.fillRectangle(0, 282, width, 2);
	}
	
	var L1X = 195; // Timer
	var L1Y = 173;
	var V1X = 195;
	var V1Y = 244;

	var L2X = null; // Heart Rate
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 195; // SmO2
	var L3Y = 286;
	var V3X = 195;
	var V3Y = 351;  

	var L4X = 195; // Power
	var L4Y = 65;
	var V4X = 195;
	var V4Y = 128;

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

	var meterX = 195; // Meter
	var meterY = 195;
	var meterR = 190;
	var meterT = 40;
}