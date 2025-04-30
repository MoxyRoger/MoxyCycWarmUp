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
    var VersionX = 160;
    var VersionY = 195;
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
		dc.fillRectangle(0, 56, width, 2);
		dc.fillRectangle(0, 112, width, 2);
		dc.fillRectangle(0, 168, width, 2);
	}
	
	var L1X = 75;
	var L2X = 75;
	var L3X = 75;
	var L4X = 75;
	var L1Y = 28;
	var L2Y = 84;
	var L3Y = 140;
	var L4Y = 196;
	var V1X = 80;
	var V2X = 80;
	var V3X = 80;
	var V4X = 80;
	var V1Y = 31;
	var V2Y = 87;
	var V3Y = 143;
	var V4Y = 199;
	var LFont = Gfx.FONT_TINY;
	var VFont = Gfx.FONT_NUMBER_HOT;
	var LJust = Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
	var VJust = Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(36, 98, 128, 2);  //Top Horizontal Line
		dc.fillRectangle(0, 162, width, 2);  //Bottom Horitzontal Line
		dc.fillRectangle(99, 162, 2, 69);    //Little Vertical Line
	}
	
	var L1X = 100; //Timer
	var L1Y = 100;
	var V1X = 100;
	var V1Y = 118;

	var L2X = 150; //HR
	var L2Y = 165;
	var V2X = 150;
	var V2Y = 181;

	var L3X = 50;  //SmO2
	var L3Y = 165;
	var V3X = 50;
	var V3Y = 181;

	var L4X = 100; //Power
	var L4Y = 35;
	var V4X = 100;
	var V4Y = 53;

	var Targ1X = 20; //Targets
	var Targ2X = 179;
	var Targ1Y = 5;
	var Targ2Y = 5;
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
