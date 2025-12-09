 using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 210;
    var TitleY = 50;
    var LineY = 255;
    var LineH = 3;
    var LabelY = 280;
    var IndicatorY = 330;
    var MO2X = 82;
    var HRX = 164;
    var FECX = 246;
    var PowerX = 328;
    var VersionX = 340;
    var VersionY = 460;
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
		dc.fillRectangle(0, 127, width, 2);
		dc.fillRectangle(0, 255, width, 2);
		dc.fillRectangle(0, 383, width, 2);
	}
	
	var L1X = 210;
	var L2X = 210;
	var L3X = 210;
	var L4X = 210;
	var L1Y = 7;
	var L2Y = 134;
	var L3Y = 262;
	var L4Y = 390;
	var V1X = 210;
	var V2X = 210;
	var V3X = 210;
	var V4X = 210;
	var V1Y = 27;
	var V2Y = 154;
	var V3Y = 282;
	var V4Y = 410;
	var LFont = Gfx.FONT_TINY;
	var VFont = Gfx.FONT_NUMBER_HOT;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;	
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(209, 383, 2, 129);
		dc.fillRectangle(0, 255, width, 2);
		dc.fillRectangle(0, 383, width, 2);
	}
	
	var L1X = 210; // Timer
	var L1Y = 262;
	var V1X = 210;
	var V1Y = 282;

	var L2X = 105; // Heart Rate
	var L2Y = 390;
	var V2X = 105;
	var V2Y = 410;

	var L3X = 315; // SmO2
	var L3Y = 390;
	var V3X = 315;
	var V3Y = 410;

	var L4X = 210; // Power
	var L4Y = 104;
	var V4X = 210;
	var V4Y = 130;

	var Targ1X = 75; //Targets
	var Targ2X = 345;
	var Targ1Y = 34;
	var Targ2Y = 34;
	var TargAng1 = 50;
	var TargAng2 = 130;

	var LFont = Gfx.FONT_TINY;
	var VNumFont = Gfx.FONT_NUMBER_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var TargFont = Gfx.FONT_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;

	var meterX = 210; //Meter
	var meterY = 210;
	var meterR = 185;
	var meterT = 40;
}

