using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 109;
    var TitleY = 16;
    var LineY = 89;
    var LineH = 2;
    var LabelY = 93;
    var IndicatorY = 136;
    var MO2X = 43;
    var HRX = 86;
    var FECX = 129;
    var PowerX = 172;
    var VersionX = 109;
    var VersionY = 155;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TitleFont = Gfx.FONT_MEDIUM;
    var LabelFont = Gfx.FONT_SMALL;
    var VersionFont = Gfx.FONT_XTINY;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 60, width, 2);
		dc.fillRectangle(0, 120, width, 2);
		dc.fillRectangle(107, 60, 2, 62);
	}
	
	var L1X = 108;
	var L2X = 108;
	var L3X = 160;
	var L4X = 58;
	var L1Y = 2;
	var L2Y = 122;
	var L3Y = 62;
	var L4Y = 62;
	var V1X = 108;
	var V2X = 108;
	var V3X = 160;
	var V4X = 58;
	var V1Y = 12;
	var V2Y = 132;
	var V3Y = 74;
	var V4Y = 74;
	var LFont = Gfx.FONT_XTINY;
	var VFont = Gfx.FONT_NUMBER_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(36, 78, 146, 2);
		dc.fillRectangle(0, 121, width, 2);
	}

	var L1X = 109;  //Timer
	var L1Y = 123;
	var V1X = 109;
	var V1Y = 157;

	var L2X = null; //HR
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 160; //SmO2
	var L3Y = 100;
	var V3X = 109;
	var V3Y = 99;

	var L4X = 109;  //Power
	var L4Y = 22;
	var V4X = 110;
	var V4Y = 55;

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

	var meterX = 108;  //Meter
	var meterY = 90;
	var meterR = 95;
	var meterT = 20;
}
