using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TimeX = 102;
    var TimeY = 40;
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
    var TimeFont = Gfx.FONT_NUMBER_THAI_HOT;
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
	var L1Y = 10;
	var L2Y = 75;
	var L3Y = 140;
	var L4Y = 205;
	var V1X = 100;
	var V2X = 100;
	var V3X = 100;
	var V4X = 100;
	var V1Y = 45;
	var V2Y = 110;
	var V3Y = 175;
	var V4Y = 240;
	var LFont = Gfx.FONT_XTINY;
	var VFont = Gfx.FONT_NUMBER_HOT;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}


module View2DeviceVars
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
	var L1Y = 10;
	var L2Y = 75;
	var L3Y = 140;
	var L4Y = 205;
	var V1X = 100;
	var V2X = 100;
	var V3X = 100;
	var V4X = 100;
	var V1Y = 45;
	var V2Y = 110;
	var V3Y = 175;
	var V4Y = 240;
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}
