using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 120;
    var TitleY = 60;
    var LineY = 180;
    var LineH = 2;
    var LabelY = 230;
    var IndicatorY = 277;
    var MO2X = 48;
    var HRX = 96;
    var FECX = 144;
    var PowerX = 192;
    var VersionX = 120;
    var VersionY = 325;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TitleFont = Gfx.FONT_MEDIUM;
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
	var L2Y = 94;
	var L3Y = 184;
	var L4Y = 274;
	var V1X = 120;
	var V2X = 120;
	var V3X = 120;
	var V4X = 120;
	var V1Y = 30;
	var V2Y = 115;
	var V3Y = 205;
	var V4Y = 295;
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
		dc.fillRectangle(0, 257, width, 2);
		dc.fillRectangle(120, 257, 2, 103);
	}
	
	var L1X = 120; //Timer
	var L1Y = 162;
	var V1X = 120;
	var V1Y = 187;

	var L2X = 180; //HR
	var L2Y = 270;
	var V2X = 180;
	var V2Y = 294;

	var L3X = 60; //SmO2
	var L3Y = 270;
	var V3X = 60;
	var V3Y = 294;

	var L4X = 120; //Power
	var L4Y = 61;
	var V4X = 120;
	var V4Y = 84;

	var Targ1X = 35; //Targets
	var Targ2X = 204;
	var Targ1Y = 11;
	var Targ2Y = 11;
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

