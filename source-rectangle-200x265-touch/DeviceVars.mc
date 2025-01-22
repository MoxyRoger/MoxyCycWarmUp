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
    var VersionX = 197;
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
		dc.fillRectangle(0, 56, width, 2);
		dc.fillRectangle(0, 112, width, 2);
		dc.fillRectangle(0, 168, width, 2);
	}
	
	var L1X = 50;
	var L2X = 50;
	var L3X = 50;
	var L4X = 50;
	var L1Y = 28;
	var L2Y = 84;
	var L3Y = 140;
	var L4Y = 196;
	var V1X = 57;
	var V2X = 57;
	var V3X = 57;
	var V4X = 57;
	var V1Y = 31;
	var V2Y = 87;
	var V3Y = 143;
	var V4Y = 199;
	var LFont = Gfx.FONT_TINY;
	var VNumFont = Gfx.FONT_NUMBER_HOT;
	var VTxtFont = Gfx.FONT_LARGE;
	var LJust = Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
	var VJust = Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
}
