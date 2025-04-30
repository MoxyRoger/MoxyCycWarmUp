using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 120;
    var TitleY = 29;
    var LineY = 120;
    var LineH = 2;
    var LabelY = 130;
    var IndicatorY = 163;
    var MO2X = 46;
    var HRX = 95;
    var FECX = 142;
    var PowerX = 190;
    var VersionX = 113;
    var VersionY = 190;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TitleFont = Gfx.FONT_LARGE;
    var LabelFont = Gfx.FONT_XTINY;
    var VersionFont = Gfx.FONT_XTINY;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 78, width, 2);
		dc.fillRectangle(0, 160, width, 2);
		dc.fillRectangle(120, 80, 2, 80);
	}
	
	var L1X = 120; // SmO2
	var L1Y = 8;
	var V1X = 120;
	var V1Y = 48;

	var L2X = 120; // THb
	var L2Y = 164;
	var V2X = 120;
	var V2Y = 204;

	var L3X = 178; // HR
	var L3Y = 86;
	var V3X = 178;
	var V3Y = 129;

	var L4X = 57;  //Cadence
	var L4Y = 86;
	var V4X = 55;
	var V4Y = 129;

	var LFont = Gfx.FONT_TINY;
	var VFont = Gfx.FONT_NUMBER_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(35, 106, 170, 2);
		dc.fillRectangle(0, 157, width, 2);
	}

	var L1X = 120;  //Timer
	var L1Y = 163;
	var V1X = 120;
	var V1Y = 205;

	var L2X = null; //HR
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 179; //SmO2
	var L3Y = 120;
	var V3X = 120;
	var V3Y = 132;

	var L4X = 120;  //Power
	var L4Y = 40;
	var V4X = 120;
	var V4Y = 81;

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

	var meterX = 120;  //Meter
	var meterY = 120;
	var meterR = 113;
	var meterT = 24;
}