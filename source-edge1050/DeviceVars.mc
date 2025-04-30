using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 240;
    var TitleY = 60;
    var LineY = 300;
    var LineH = 3;
    var LabelY = 330;
    var IndicatorY = 377;
    var MO2X = 96;
    var HRX = 192;
    var FECX = 288;
    var PowerX = 384;
    var VersionX = 360;
    var VersionY = 500;
    var VersionJ = Gfx.TEXT_JUSTIFY_RIGHT;
    var TitleFont = Gfx.FONT_LARGE;
    var LabelFont = Gfx.FONT_SMALL;
    var VersionFont = Gfx.FONT_SMALL;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 177, width, 2);
		dc.fillRectangle(0, 354, width, 2);
		dc.fillRectangle(0, 531, width, 2);
	}
	
	var L1X = 240;
	var L2X = 240;
	var L3X = 240;
	var L4X = 240;
	var L1Y = 10;
	var L2Y = 187;
	var L3Y = 364;
	var L4Y = 541;
	var V1X = 240;
	var V2X = 240;
	var V3X = 240;
	var V4X = 240;
	var V1Y = 40;
	var V2Y = 217;
	var V3Y = 394;
	var V4Y = 571;
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
		dc.fillRectangle(0, 294, width, 2);
		dc.fillRectangle(0, 500, width, 2);
		dc.fillRectangle(239, 500, 2, 206);
	}
	
	var L1X = 240; //Timer
	var L1Y = 319;
	var V1X = 240;
	var V1Y = 344;

	var L2X = 360; //HR
	var L2Y = 525;
	var V2X = 360;
	var V2Y = 550;

	var L3X = 120; //SmO2
	var L3Y = 525;
	var V3X = 120;
	var V3Y = 550;

	var L4X = 240; //Power
	var L4Y = 115;
	var V4X = 240;
	var V4Y = 140;

	var Targ1X = 75; //Targets
	var Targ2X = 405;
	var Targ1Y = 21;
	var Targ2Y = 21;
	var TargAng1 = 50;
	var TargAng2 = 130;

	var LFont = Gfx.FONT_SMALL;
	var VNumFont = Gfx.FONT_NUMBER_THAI_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var TargFont = Gfx.FONT_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;

	var meterX = 240; //Meter
	var meterY = 240;
	var meterR = 230;
	var meterT = 50;
}

