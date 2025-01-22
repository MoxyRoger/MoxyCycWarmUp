using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TimeX = 109;
    var TimeY = 16;
    var LineY = 89;
    var LineH = 2;
    var LabelY = 93;
    var IndicatorY = 136;
    var MO2X = 43;
    var HRX = 86;
    var FECX = 129;
    var PowerX = 172;
    var VersionX = 109;
    var VersionY = 155;
    var VersionJ = Gfx.TEXT_JUSTIFY_CENTER;
    var TimeFont = Gfx.FONT_NUMBER_HOT;
    var LabelFont = Gfx.FONT_SMALL;
    var VersionFont = Gfx.FONT_XTINY;	
}

module View1DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 60, width, 2);
		dc.fillRectangle(0, 120, width, 2);
		dc.fillRectangle(107, 60, 2, 62);
	}
	
	var L1X = 108;
	var L2X = 108;
	var L3X = 160;
	var L4X = 58;
	var L1Y = 2;
	var L2Y = 122;
	var L3Y = 62;
	var L4Y = 62;
	var V1X = 108;
	var V2X = 108;
	var V3X = 160;
	var V4X = 58;
	var V1Y = 12;
	var V2Y = 132;
	var V3Y = 74;
	var V4Y = 74;
	var LFont = Gfx.FONT_XTINY;
	var VFont = Gfx.FONT_NUMBER_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 60, width, 2);
		dc.fillRectangle(0, 120, width, 2);
		dc.fillRectangle(107, 60, 2, 62);
	}
	
	var L1X = 108;
	var L2X = 108;
	var L3X = 160;
	var L4X = 58;
	var L1Y = 2;
	var L2Y = 122;
	var L3Y = 62;
	var L4Y = 62;
	var V1X = 108;
	var V2X = 108;
	var V3X = 160;
	var V4X = 58;
	var V1Y = 12;
	var V2Y = 132;
	var V3Y = 74;
	var V4Y = 74;
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_MEDIUM;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER;
}
