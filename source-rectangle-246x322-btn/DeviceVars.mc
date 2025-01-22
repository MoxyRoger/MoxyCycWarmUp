using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TimeX = 125;
    var TimeY = 50;
    var LineY = 132;
    var LineH = 2;
    var LabelY = 145;
    var IndicatorY = 187;
    var MO2X = 49;
    var HRX = 98;
    var FECX = 147;
    var PowerX = 196;
    var VersionX = 197;
    var VersionY = 280;
    var VersionJ = Gfx.TEXT_JUSTIFY_RIGHT;
    var TimeFont = Gfx.FONT_NUMBER_THAI_HOT;
    var LabelFont = Gfx.FONT_SMALL;
    var VersionFont = Gfx.FONT_SMALL;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 81, width, 2);
		dc.fillRectangle(0, 162, width, 2);
		dc.fillRectangle(0, 243, width, 2);
	}
	
	var L1X = 125;
	var L2X = 125;
	var L3X = 125;
	var L4X = 125;
	var L1Y = 3;
	var L2Y = 84;
	var L3Y = 165;
	var L4Y = 246;
	var V1X = 125;
	var V2X = 125;
	var V3X = 125;
	var V4X = 125;
	var V1Y = 27;
	var V2Y = 108;
	var V3Y = 189;
	var V4Y = 270;
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
		dc.fillRectangle(0, 81, width, 2);
		dc.fillRectangle(0, 162, width, 2);
		dc.fillRectangle(0, 243, width, 2);
	}
	
	var L1X = 125;
	var L2X = 125;
	var L3X = 125;
	var L4X = 125;
	var L1Y = 3;
	var L2Y = 84;
	var L3Y = 165;
	var L4Y = 246;
	var V1X = 125;
	var V2X = 125;
	var V3X = 125;
	var V4X = 125;
	var V1Y = 27;
	var V2Y = 108;
	var V3Y = 189;
	var V4Y = 270;
	var LFont = Gfx.FONT_SMALL;
	var VNumFont = Gfx.FONT_NUMBER_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;
}
