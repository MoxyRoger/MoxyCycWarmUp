using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 120;
    var TitleY = 40;
    var LineY = 119;
    var LineH = 2;
    var LabelY = 124;
    var IndicatorY = 160;
    var MO2X = 48;
    var HRX = 96;
    var FECX = 144;
    var PowerX = 192;
    var VersionX = 120;
    var VersionY = 180;
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
		dc.fillRectangle(0, 82, width, 2);
		dc.fillRectangle(0, 161, width, 2);
		dc.fillRectangle(119, 82, 2, 79);
	}
	
	var L1X = 119;
	var L2X = 119;
	var L3X = 175;
	var L4X = 65;
	var L1Y = 6;
	var L2Y = 160;
	var L3Y = 82;
	var L4Y = 82;
	var V1X = 119;
	var V2X = 119;
	var V3X = 175;
	var V4X = 65;
	var V1Y = 50;
	var V2Y = 203;
	var V3Y = 130;
	var V4Y = 130;
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
		dc.fillRectangle(40, 110, 160, 2);
		dc.fillRectangle(0, 160, width, 2);
	}

	var L1X = 120;  //Timer
	var L1Y = 162;
	var V1X = 120;
	var V1Y = 207;

	var L2X = null; //HR
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 175; //SmO2
	var L3Y = 125;
	var V3X = 120;
	var V3Y = 135;

	var L4X = 120;  //Power
	var L4Y = 40;
	var V4X = 120;
	var V4Y = 85;

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
	var meterR = 115;
	var meterT = 20;
}