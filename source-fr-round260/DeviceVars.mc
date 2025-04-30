using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 130;
    var TitleY = 40;
    var LineY = 129;
    var LineH = 2;
    var LabelY = 142;
    var IndicatorY = 185;
    var MO2X = 43;
    var HRX = 101;
    var FECX = 159;
    var PowerX = 217;
    var VersionX = 130;
    var VersionY = 205;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TitleFont = Gfx.FONT_MEDIUM;
    var LabelFont = Gfx.FONT_TINY;
    var VersionFont = Gfx.FONT_XTINY;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 89, width, 2);
		dc.fillRectangle(0, 174, width, 2);
		dc.fillRectangle(129, 89, 2, 85);
	}
	
	var L1X = 129;
	var L2X = 129;
	var L3X = 185;
	var L4X = 67;
	var L1Y = 14;
	var L2Y = 229;
	var L3Y = 95;
	var L4Y = 95;
	var V1X = 129;
	var V2X = 129;
	var V3X = 185;
	var V4X = 67;
	var V1Y = 62;
	var V2Y = 203;
	var V3Y = 143;
	var V4Y = 143;
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
		dc.fillRectangle(40, 110, 180, 2);
		dc.fillRectangle(0, 168, width, 2);
	}

	var L1X = 130;  //Timer
	var L1Y = 176;
	var V1X = 130;
	var V1Y = 221;

	var L2X = null; //HR
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 191; //SmO2
	var L3Y = 130;
	var V3X = 130;
	var V3Y = 140;

	var L4X = 130;  //Power
	var L4Y = 40;
	var V4X = 130;
	var V4Y = 84;

	var Targ1X = null;  //Targets
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

	var meterX = 130;  //Meter
	var meterY = 130;
	var meterR = 125;
	var meterT = 20;
}