using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TimeX = 227;
    var TimeY = 50;
    var LineY = 226;
    var LineH = 2;
    var LabelY = 240;
    var IndicatorY = 305;
    var MO2X = 92;
    var HRX = 182;
    var FECX = 272;
    var PowerX = 362;
    var VersionX = 227;
    var VersionY = 335;
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
		dc.fillRectangle(0, 158, width, 2);
		dc.fillRectangle(0, 294, width, 2);
		dc.fillRectangle(226, 158, 2, 138);
	}
	
	var L1X = 226;
	var L2X = 226;
	var L3X = 330;
	var L4X = 119;
	var L1Y = 20;
	var L2Y = 405;
	var L3Y = 164;
	var L4Y = 164;
	var V1X = 226;
	var V2X = 226;
	var V3X = 330;
	var V4X = 119;
	var V1Y = 105;
	var V2Y = 350;
	var V3Y = 244;
	var V4Y = 244;
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
		dc.fillRectangle(0, 158, width, 2);
		dc.fillRectangle(0, 294, width, 2);
		dc.fillRectangle(226, 158, 2, 138);
	}
	
	var L1X = 226;
	var L2X = 226;
	var L3X = 335;
	var L4X = 125;
	var L1Y = 20;
	var L2Y = 405;
	var L3Y = 164;
	var L4Y = 164;
	var V1X = 226;
	var V2X = 226;
	var V3X = 335;
	var V4X = 125;
	var V1Y = 95;
	var V2Y = 355;
	var V3Y = 249;
	var V4Y = 249;
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_MEDIUM;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}
