using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 120;
    var TitleY = 60;
    var LineY = 170;
    var LineH = 2;
    var LabelY = 205;
    var IndicatorY = 250;
    var MO2X = 48;
    var HRX = 96;
    var FECX = 144;
    var PowerX = 192;
    var VersionX = 120;
    var VersionY = 325;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TitleFont = Gfx.FONT_LARGE;
    var LabelFont = Gfx.FONT_SMALL;
    var VersionFont = Gfx.FONT_SMALL;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 90, width, 2);
		dc.fillRectangle(0, 180, width, 2);
		dc.fillRectangle(0, 270, width, 2);
	}
	
	var L1X = 120;
	var L2X = 120;
	var L3X = 120;
	var L4X = 120;
	var L1Y = 4;
	var L2Y = 92;
	var L3Y = 184;
	var L4Y = 274;
	var V1X = 120;
	var V2X = 120;
	var V3X = 120;
	var V4X = 120;
	var V1Y = 15;
	var V2Y = 101;
	var V3Y = 191;
	var V4Y = 281;
	var LFont = Gfx.FONT_SMALL;
	var VFont = Gfx.FONT_NUMBER_THAI_HOT;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;	
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 150, width, 2);
		dc.fillRectangle(0, 255, width, 2);
		dc.fillRectangle(120, 255, 2, 103);
	}
	
	var L1X = 120; //Timer
	var L1Y = 160;
	var V1X = 120;
	var V1Y = 175;

	var L2X = 180; //HR
	var L2Y = 267;
	var V2X = 180;
	var V2Y = 275;

	var L3X = 60; //SmO2
	var L3Y = 267;
	var V3X = 60;
	var V3Y = 275;

	var L4X = 120; //Power
	var L4Y = 61;
	var V4X = 120;
	var V4Y = 72;

	var Targ1X = 35; //Targets
	var Targ2X = 204;
	var Targ1Y = 8;
	var Targ2Y = 8;
	var TargAng1 = 50;
	var TargAng2 = 130;

	var LFont = Gfx.FONT_SMALL;
	var VNumFont = Gfx.FONT_NUMBER_THAI_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var TargFont = Gfx.FONT_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;

	var meterX = 120; //Meter
	var meterY = 121;
	var meterR = 115;
	var meterT = 30;
}

