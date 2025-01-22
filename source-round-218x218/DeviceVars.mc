using Toybox.Graphics as Gfx;

module View0DeviceVars
{
	var TimeX = 109;
    var TimeY = 26;
    var LineY = 108;
    var LineH = 2;
    var LabelY = 112;
    var IndicatorY = 150;
    var MO2X = 43;
    var HRX = 86;
    var FECX = 129;
    var PowerX = 172;
    var VersionX = 109;
    var VersionY = 160;
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
		dc.fillRectangle(0, 69, width, 2);
		dc.fillRectangle(0, 145, width, 2);
		dc.fillRectangle(108, 69, 2, 78);
	}
	
	var L1X = 108;
	var L2X = 108;
	var L3X = 164;
	var L4X = 54;
	var L1Y = 12;
	var L2Y = 156;
	var L3Y = 80;
	var L4Y = 80;
	var V1X = 108;
	var V2X = 108;
	var V3X = 164;
	var V4X = 54;	
	var V1Y = 42;
	var V2Y = 185;
	var V3Y = 115;
	var V4Y = 115;
	var LFont = Gfx.FONT_XTINY;
	var VFont = Gfx.FONT_NUMBER_MEDIUM;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}


module View2DeviceVars
{
	function drawGrid(dc) {
		var width = dc.getWidth();
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
		dc.fillRectangle(0, 69, width, 2);
		dc.fillRectangle(0, 145, width, 2);
		dc.fillRectangle(108, 69, 2, 78);
	}
	
	var L1X = 108;
	var L2X = 108;
	var L3X = 164;
	var L4X = 54;
	var L1Y = 14;
	var L2Y = 156;
	var L3Y = 80;
	var L4Y = 80;
	var V1X = 108;
	var V2X = 108;
	var V3X = 164;
	var V4X = 54;	
	var V1Y = 48;
	var V2Y = 185;
	var V3Y = 115;
	var V4Y = 115;
	var LFont = Gfx.FONT_XTINY;
	var VNumFont = Gfx.FONT_NUMBER_MEDIUM;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
	var VJust = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
}

