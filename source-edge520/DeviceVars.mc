using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TitleX = 102;
    var TitleY = 40;
    var LineY = 112;
    var LineH = 2;
    var LabelY = 125;
    var IndicatorY = 167;
    var MO2X = 41;
    var HRX = 82;
    var FECX = 123;
    var PowerX = 164;
    var VersionX = 100;
    var VersionY = 205;
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
		dc.fillRectangle(0, 65, width, 2);
		dc.fillRectangle(0, 130, width, 2);
		dc.fillRectangle(0, 195, width, 2);
	}
	
	var L1X = 100;
	var L2X = 100;
	var L3X = 100;
	var L4X = 100;
	var L1Y = 2;
	var L2Y = 67;
	var L3Y = 134;
	var L4Y = 199;
	var V1X = 100;
	var V2X = 100;
	var V3X = 100;
	var V4X = 100;
	var V1Y = 21;
	var V2Y = 86;
	var V3Y = 151;
	var V4Y = 220;
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
		dc.fillRectangle(0, 130, width, 2);  //Top Horizontal Line
		dc.fillRectangle(0, 195, width, 2);  //Bottom Horitzontal Line
		dc.fillRectangle(99, 195, 2, 69);    //Little Vertical Line
	}
	
	var L1X = 100; //Timer
	var L1Y = 134;
	var V1X = 100;
	var V1Y = 151;

	var L2X = 150; //HR
	var L2Y = 199;
	var V2X = 150;
	var V2Y = 220;

	var L3X = 50;  //SmO2
	var L3Y = 199;
	var V3X = 50;
	var V3Y = 220;

	var L4X = 100; //Power
	var L4Y = 60;
	var V4X = 100;
	var V4Y = 80;

	var Targ1X = 23; //Targets
	var Targ2X = 176;
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
	var meterX = 100;
	var meterY = 100;
	var meterR = 95;
	var meterT = 20;
}
