using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TimeX = 140;
    var TimeY = 50;
    var LineY = 139;
    var LineH = 2;
    var LabelY = 152;
    var IndicatorY = 195;
    var MO2X = 43;
    var HRX = 108;
    var FECX = 172;
    var PowerX = 237;
    var VersionX = 140;
    var VersionY = 225;
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
		dc.fillRectangle(0, 99, width, 2);
		dc.fillRectangle(0, 184, width, 2);
		dc.fillRectangle(139, 99, 2, 85);
	}
	
	var L1X = 139;
	var L2X = 139;
	var L3X = 195;
	var L4X = 77;
	var L1Y = 15;
	var L2Y = 245;
	var L3Y = 105;
	var L4Y = 105;
	var V1X = 139;
	var V2X = 139;
	var V3X = 195;
	var V4X = 77;
	var V1Y = 65;
	var V2Y = 220;
	var V3Y = 153;
	var V4Y = 153;
	var LFont = Gfx.FONT_XTINY;
	var VFont = Gfx.FONT_NUMBER_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 99, width, 2);
		dc.fillRectangle(0, 184, width, 2);
		dc.fillRectangle(139, 99, 2, 85);
	}
	
	var L1X = 139;
	var L2X = 139;
	var L3X = 195;
	var L4X = 77;
	var L1Y = 15;
	var L2Y = 245;
	var L3Y = 105;
	var L4Y = 105;
	var V1X = 139;
	var V2X = 139;
	var V3X = 195;
	var V4X = 77;
	var V1Y = 65;
	var V2Y = 220;
	var V3Y = 153;
	var V4Y = 153;
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_MEDIUM;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}
