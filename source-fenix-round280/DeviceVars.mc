using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TitleX = 140;
    var TitleY = 45;
    var LineY = 139;
    var LineH = 2;
    var LabelY = 152;
    var IndicatorY = 195;
    var MO2X = 43;
    var HRX = 108;
    var FECX = 172;
    var PowerX = 237;
    var VersionX = 140;
    var VersionY = 225;
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
		dc.fillRectangle(0, 99, width, 2);
		dc.fillRectangle(0, 184, width, 2);
		dc.fillRectangle(139, 99, 2, 85);
	}
	
	var L1X = 139;
	var L2X = 139;
	var L3X = 195;
	var L4X = 77;
	var L1Y = 15;
	var L2Y = 245;
	var L3Y = 105;
	var L4Y = 105;
	var V1X = 139;
	var V2X = 139;
	var V3X = 195;
	var V4X = 77;
	var V1Y = 65;
	var V2Y = 220;
	var V3Y = 153;
	var V4Y = 153;
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
		dc.fillRectangle(50, 115, 173, 2);
		dc.fillRectangle(0, 180, width, 2);
	}

	var L1X = 140;  //Timer
	var L1Y = 187;
	var V1X = 140;
	var V1Y = 234;

	var L2X = null; //HR
	var L2Y = null;
	var V2X = null;
	var V2Y = null;

	var L3X = 200; //SmO2
	var L3Y = 135;
	var V3X = 140;
	var V3Y = 148;

	var L4X = 140;  //Power
	var L4Y = 40;
	var V4X = 140;
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

	var meterX = 140;  //Meter
	var meterY = 140;
	var meterR = 130;
	var meterT = 20;
}