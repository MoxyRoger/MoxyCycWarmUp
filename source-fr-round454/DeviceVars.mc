using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 227;
    var TitleY = 65;
    var LineY = 226;
    var LineH = 2;
    var LabelY = 240;
    var IndicatorY = 305;
    var MO2X = 92;
    var HRX = 182;
    var FECX = 272;
    var PowerX = 362;
    var VersionX = 227;
    var VersionY = 335;
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
		dc.fillRectangle(0, 158, width, 2);
		dc.fillRectangle(0, 294, width, 2);
		dc.fillRectangle(226, 158, 2, 138);
	}
	
	var L1X = 226;
	var L2X = 226;
	var L3X = 330;
	var L4X = 119;
	var L1Y = 20;
	var L2Y = 405;
	var L3Y = 164;
	var L4Y = 164;
	var V1X = 226;
	var V2X = 226;
	var V3X = 330;
	var V4X = 119;
	var V1Y = 105;
	var V2Y = 350;
	var V3Y = 244;
	var V4Y = 244;
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
		dc.fillRectangle(84, 200, 285, 2);
		dc.fillRectangle(0, 321, width, 2);
	}
	
	var L1X = 226; // Timer
	var L1Y = 203;
	var V1X = 226;
	var V1Y = 277;

	var L2X = null; // Heart Rate
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 226; // SmO2
	var L3Y = 326;
	var V3X = 226;
	var V3Y = 400;  

	var L4X = 226; // Power
	var L4Y = 85;
	var V4X = 226;
	var V4Y = 157;

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

	var meterX = 226; // Meter
	var meterY = 226;
	var meterR = 210;
	var meterT = 50;
}