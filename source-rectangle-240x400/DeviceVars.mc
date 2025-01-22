using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TimeX = 120;
    var TimeY = 60;
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
    var TimeFont = Gfx.FONT_NUMBER_THAI_HOT;
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
	var VNumFont = Gfx.FONT_NUMBER_THAI_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;
}
