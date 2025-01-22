using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TimeX = 180;
    var TimeY = 50;
    var LineY = 179;
    var LineH = 2;
    var LabelY = 190;
    var IndicatorY = 245;
    var MO2X = 51;
    var HRX = 138;
    var FECX = 222;
    var PowerX = 309;
    var VersionX = 180;
    var VersionY = 270;
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
		dc.fillRectangle(0, 119, width, 2);
		dc.fillRectangle(0, 239, width, 2);
		dc.fillRectangle(179, 119, 2, 122);
	}
	
	var L1X = 180;
	var L2X = 180;
	var L3X = 270;
	var L4X = 90;
	var L1Y = 15;
	var L2Y = 330;
	var L3Y = 125;
	var L4Y = 125;
	var V1X = 180;
	var V2X = 180;
	var V3X = 270;
	var V4X = 90;
	var V1Y = 80;
	var V2Y = 290;
	var V3Y = 195;
	var V4Y = 195;
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
		dc.fillRectangle(0, 119, width, 2);
		dc.fillRectangle(0, 239, width, 2);
		dc.fillRectangle(179, 119, 2, 122);
	}
	
	var L1X = 180;
	var L2X = 180;
	var L3X = 270;
	var L4X = 90;
	var L1Y = 15;
	var L2Y = 330;
	var L3Y = 125;
	var L4Y = 125;
	var V1X = 180;
	var V2X = 180;
	var V3X = 270;
	var V4X = 90;
	var V1Y = 95;
	var V2Y = 290;
	var V3Y = 195;
	var V4Y = 195;
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_MEDIUM;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}
