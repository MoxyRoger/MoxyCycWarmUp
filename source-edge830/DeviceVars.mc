using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 125;
    var TitleY = 30;
    var LineY = 132;
    var LineH = 2;
    var LabelY = 145;
    var IndicatorY = 187;
    var MO2X = 49;
    var HRX = 98;
    var FECX = 147;
    var PowerX = 196;
    var VersionX = 197;
    var VersionY = 240;
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
		dc.fillRectangle(0, 71, width, 2);
		dc.fillRectangle(0, 142, width, 2);
		dc.fillRectangle(0, 213, width, 2);
	}
	
	var L1X = 125;
	var L2X = 125;
	var L3X = 125;
	var L4X = 125;
	var L1Y = 1;
	var L2Y = 72;
	var L3Y = 143;
	var L4Y = 213;
	var V1X = 125;
	var V2X = 125;
	var V3X = 125;
	var V4X = 125;
	var V1Y = 22;
	var V2Y = 93;
	var V3Y = 164;
	var V4Y = 232;
	var LFont = Gfx.FONT_SMALL;
	var VFont = Gfx.FONT_NUMBER_HOT;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;	
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 142, width, 2);
		dc.fillRectangle(0, 213, width, 2);
		dc.fillRectangle(122, 213, 2, 109);
	}
	
	var L1X = 123; //Timer
	var L1Y = 143;
	var V1X = 123;
	var V1Y = 164;

	var L2X = 185; //HR
	var L2Y = 212;
	var V2X = 185;
	var V2Y = 232;

	var L3X = 62;  //SmO2
	var L3Y = 212;
	var V3X = 62;
	var V3Y = 232;

	var L4X = 123; //Power
	var L4Y = 57;
	var V4X = 123;
	var V4Y = 80;

	var Targ1X = 27; //Targets
	var Targ2X = 222;
	var Targ1Y = 10;
	var Targ2Y = 10;
	var TargAng1 = 50;
	var TargAng2 = 130;
	
	var LFont = Gfx.FONT_SMALL;
	var VNumFont = Gfx.FONT_NUMBER_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var TargFont = Gfx.FONT_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;
	var meterX = 123;
	var meterY = 128;
	var meterR = 123;
	var meterT = 25;
}
