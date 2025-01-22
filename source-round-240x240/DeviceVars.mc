using Toybox.Graphics as Gfx;
using Toybox.System;

module View0DeviceVars
{
	var TimeX = 120;
    var TimeY = 40;
    var LineY = 119;
    var LineH = 2;
    var LabelY = 124;
    var IndicatorY = 160;
    var MO2X = 48;
    var HRX = 96;
    var FECX = 144;
    var PowerX = 192;
    var VersionX = 120;
    var VersionY = 170;
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
		dc.fillRectangle(0, 82, width, 2);
		dc.fillRectangle(0, 161, width, 2);
		dc.fillRectangle(119, 82, 2, 79);
	}
	
	var L1X = 119;
	var L2X = 119;
	var L3X = 175;
	var L4X = 65;
	var L1Y = 6;
	var L2Y = 160;
	var L3Y = 82;
	var L4Y = 82;
	var V1X = 119;
	var V2X = 119;
	var V3X = 175;
	var V4X = 65;
	var V1Y = 50;
	var V2Y = 203;
	var V3Y = 130;
	var V4Y = 130;
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
		dc.fillRectangle(0, 82, width, 2);
		dc.fillRectangle(0, 161, width, 2);
		dc.fillRectangle(119, 82, 2, 79);
	}

	var L1X = 119;
	var L2X = 119;
	var L3X = 175;
	var L4X = 65;
	var L1Y = 6;
	var L2Y = 160;
	var L3Y = 82;
	var L4Y = 82;
	var V1X = 119;
	var V2X = 119;
	var V3X = 175;
	var V4X = 65;
	var V1Y = 60;
	var V2Y = 203;
	var V3Y = 130;
	var V4Y = 130;
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_MEDIUM;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}

