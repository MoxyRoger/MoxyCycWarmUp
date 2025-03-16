using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 125;
    var TitleY = 50;
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
	var L1Y = 5;
	var L2Y = 76;
	var L3Y = 147;
	var L4Y = 218;
	var V1X = 125;
	var V2X = 125;
	var V3X = 125;
	var V4X = 125;
	var V1Y = 20;
	var V2Y = 91;
	var V3Y = 162;
	var V4Y = 230;
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
	var L1Y = 147;
	var V1X = 123;
	var V1Y = 162;

	var L2X = 185; //HR
	var L2Y = 218;
	var V2X = 185;
	var V2Y = 230;

	var L3X = 62;  //SmO2
	var L3Y = 218;
	var V3X = 62;
	var V3Y = 230;

	var L4X = 123; //Power
	var L4Y = 67;
	var V4X = 123;
	var V4Y = 80;

	var Targ1X = 35; //Targets
	var Targ2X = 215;
	var Targ1Y = 14;
	var Targ2Y = 14;
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
