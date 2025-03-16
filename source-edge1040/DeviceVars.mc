using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 141;
    var TitleY = 60;
    var LineY = 180;
    var LineH = 2;
    var LabelY = 230;
    var IndicatorY = 277;
    var MO2X = 48;
    var HRX = 110;
    var FECX = 172;
    var PowerX = 234;
    var VersionX = 237;
    var VersionY = 340;
    var VersionJ = Gfx.TEXT_JUSTIFY_RIGHT;
    var TitleFont = Gfx.FONT_NUMBER_THAI_HOT;
    var LabelFont = Gfx.FONT_SMALL;
    var VersionFont = Gfx.FONT_SMALL;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 100, width, 2);
		dc.fillRectangle(0, 200, width, 2);
		dc.fillRectangle(0, 300, width, 2);
	}
	
	var L1X = 141;
	var L2X = 141;
	var L3X = 141;
	var L4X = 141;
	var L1Y = 4;
	var L2Y = 104;
	var L3Y = 204;
	var L4Y = 304;
	var V1X = 141;
	var V2X = 141;
	var V3X = 141;
	var V4X = 141;
	var V1Y = 28;
	var V2Y = 128;
	var V3Y = 228;
	var V4Y = 328;
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
		dc.fillRectangle(0, 100, width, 2);
		dc.fillRectangle(0, 200, width, 2);
		dc.fillRectangle(0, 300, width, 2);
	}
	
	var L1X = 141; //Timer
	var L1Y = 4;
	var V1X = 141;
	var V1Y = 28;

	var L2X = 141; //HR
	var L2Y = 104;
	var V2X = 141;
	var V2Y = 128;

	var L3X = 141; //SmO2
	var L3Y = 204;
	var V3X = 141;
	var V3Y = 228;

	var L4X = 141; //Power
	var L4Y = 304;
	var V4X = 141;
	var V4Y = 328;

	var Targ1X = 35; //Targets
	var Targ2X = 215;
	var Targ1Y = 14;
	var Targ2Y = 14;
	var TargAng1 = 50;
	var TargAng2 = 130;

	var LFont = Gfx.FONT_SMALL;
	var VNumFont = Gfx.FONT_NUMBER_THAI_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var TargFont = Gfx.FONT_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;

	var meterX = 123; //Meter
	var meterY = 128;
	var meterR = 123;
	var meterT = 25;
}

