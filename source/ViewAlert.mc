using Toybox.Application as App;
using Toybox.Attention as Attention;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;

enum {
    BTN_LAP,
    BTN_START,
    BTN_STOP,
    BTN_NONE,
    STP_WARM,
    STP_PREP,
    STP_SPRINT,
    STP_REST,
    STP_STEP,
    STP_COOL
}

class ViewAlert extends Ui.View {
    hidden var prevBtnAlert = BTN_NONE;
//    hidden var prevSmO2Alert = SMO2_ALERT_NONE;
    hidden var timeStartAlert;
    hidden var mSensor;
    hidden var g_ScaleFactorX;
    hidden var g_ScaleFactorY;
    hidden var g_BASE_WIDTH_X = 240.0;    // based screen resolution used X
    hidden var g_BASE_HEIGHT_Y = 240.0;   // based screen resolutoin used Y

    function initialize(sensor) {
        View.initialize();
        mSensor = sensor;
    }

    function checkAlerts(dc) {
        var info = Sys.getDeviceSettings();
        var temp_val;
        temp_val = dc.getWidth();
//        g_ScaleFactorX = (g_BASE_WIDTH_X /temp_val);
        g_ScaleFactorX = (temp_val  / g_BASE_WIDTH_X);
        temp_val = dc.getHeight();
//        g_ScaleFactorY = (g_BASE_HEIGHT_Y / temp_val);
        g_ScaleFactorY = (temp_val / g_BASE_HEIGHT_Y);
//        g_ScaleFactorX = (dc.getWidth()  / g_BASE_WIDTH_X);
//        g_ScaleFactorY = (dc.getHeight() / g_BASE_HEIGHT_Y);
 
        if (App.getApp().btnAlert != BTN_NONE) {
            if (prevBtnAlert != App.getApp().btnAlert) {
                timeStartAlert = Sys.getTimer();
                if (info.tonesOn) {
                    if (App.getApp().btnAlert == BTN_START) {
                        Attention.playTone(Attention.TONE_START);
                    }
                    else if (App.getApp().btnAlert == BTN_STOP) {
                        Attention.playTone(Attention.TONE_STOP);
                    }
                    else if (App.getApp().btnAlert == BTN_LAP) {
                        Attention.playTone(Attention.TONE_LAP);
                    }
                    else {
                        Attention.playTone(Attention.TONE_LOUD_BEEP);
                    }
                }
                if (info.vibrateOn) {
                    var profile = [new Attention.VibeProfile(VIBRATE_DUTY_CYCLE, VIBRATE_PERIOD)];
                    Attention.vibrate(profile);
                }
            }
            if (App.getApp().btnAlert == BTN_LAP) {
                if (Sys.getTimer() - timeStartAlert > 5000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawLapAlert(dc);
                }
            }
            else if (App.getApp().btnAlert == BTN_START) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawStartAlert(dc);
                }
            }
            else if (App.getApp().btnAlert == BTN_STOP) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawStopAlert(dc);
                }
            }
            else if (App.getApp().btnAlert == STP_WARM) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawSmo2Alert(dc, "WARMUP");
                }
            }
            else if (App.getApp().btnAlert == STP_PREP) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawSmo2Alert(dc, "STOP!");
                }
            }
            else if (App.getApp().btnAlert == STP_SPRINT) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawSmo2Alert(dc, "SPRINT!");
                }
            }
            else if (App.getApp().btnAlert == STP_REST) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawSmo2Alert(dc, "REST");
                }
            }
            else if (App.getApp().btnAlert == STP_STEP) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawSmo2Alert(dc, "Step " + App.getApp().loadStep);
                }
            }
            else if (App.getApp().btnAlert == STP_COOL) {
                if (Sys.getTimer() - timeStartAlert > 2000) {
                    App.getApp().clearBtnAlert();
                }
                else {
                    drawSmo2Alert(dc, "COOLDOWN");
                }
            }
        }
        prevBtnAlert = App.getApp().btnAlert;
    }

    function drawLapAlert(dc) {
        var font_head = Gfx.FONT_LARGE;
        var font_label = Gfx.FONT_SMALL;
        var font_num = Gfx.FONT_NUMBER_MEDIUM;
        var fgcolor = Gfx.COLOR_BLACK;
        var bgcolor = Gfx.COLOR_WHITE;
        var distConv;
        var text;
        var tHeight_num;
        var tHeight_label;
        var xCen = dc.getWidth() / 2;
        var yCen = dc.getHeight() / 2;
        var x;
        var y;

		if ((dc.getWidth() <= 215) || (dc.getHeight() <= 215)){
            font_head = Gfx.FONT_MEDIUM;
            font_label = Gfx.FONT_SMALL;
            font_num = Gfx.FONT_NUMBER_MILD;
  		}

        tHeight_num = dc.getFontHeight(font_num);
        tHeight_label = dc.getFontHeight(font_label);

        dc.setColor(bgcolor, bgcolor);
        dc.clear();
        dc.setColor(fgcolor, Gfx.COLOR_TRANSPARENT);
        if (Sys.getDeviceSettings().distanceUnits == Sys.UNIT_STATUTE) {
            distConv = 0.000621371; //convert meters to miles
        }
        else {
            distConv = 0.001; // convert meters to kilometers
        }
        text = "Lap";
        x = xCen;
        y = yCen - ((70.0 * g_ScaleFactorY).toNumber());
        dc.drawText(x, y, font_head, text, Gfx.TEXT_JUSTIFY_CENTER);
//        dc.drawText(xCen, yCen - 70, font_head, text, Gfx.TEXT_JUSTIFY_CENTER);

        x = xCen - (25.0 * g_ScaleFactorX).toNumber();
        y = yCen - ((15.0 * g_ScaleFactorY) + (0.5 * tHeight_label)).toNumber();
        text = "Time: ";
        dc.drawText(x, y, font_label, text, Gfx.TEXT_JUSTIFY_RIGHT);
//        dc.drawText(xCen-25, yCen - 15 - 0.5 * tHeight_label, font_label, text, Gfx.TEXT_JUSTIFY_RIGHT);

        x = xCen - (25.0 * g_ScaleFactorX).toNumber();
        y = yCen - ((15.0 * g_ScaleFactorY) + (0.5 * tHeight_num)).toNumber();
//        y = yCen - ((15.0 * g_ScaleFactorY) + (0.5 * tHeight_num)).toNumber();
        text = format_elapsed_time(((App.getApp().lapStartTime - App.getApp().lapPrevTime)/1000).toNumber());
        dc.drawText(x, y, font_num, text, Gfx.TEXT_JUSTIFY_LEFT);
//        dc.drawText(xCen-25, yCen - 15 - 0.5 * tHeight_num, font_num, text, Gfx.TEXT_JUSTIFY_LEFT);

        x = xCen - (25.0 * g_ScaleFactorX).toNumber();
        y = yCen + ((30.0 * g_ScaleFactorY) - (0.5 * tHeight_label)).toNumber();
        text = "Dist: ";
        dc.drawText(x, y, font_label, text, Gfx.TEXT_JUSTIFY_RIGHT);
//        dc.drawText(xCen-25, yCen + 30 - 0.5 * tHeight_label, font_label, text, Gfx.TEXT_JUSTIFY_RIGHT);

        x = xCen - (25.0 * g_ScaleFactorX).toNumber();
        y = yCen + ((30.0 * g_ScaleFactorY) - (0.5 * tHeight_num)).toNumber();    //TODO:
//        y = yCen + ((30.0 * g_ScaleFactorY) - (0.5 * tHeight_num)).toNumber();    //TODO:
        text = ((App.getApp().lapStartDist - App.getApp().lapPrevDist) * distConv).format("%.2f");
        dc.drawText(x, y, font_num, text, Gfx.TEXT_JUSTIFY_LEFT);
//        dc.drawText(xCen-25, yCen + 30 - 0.5 * tHeight_num, font_num, text, Gfx.TEXT_JUSTIFY_LEFT);


    }

    function drawStartAlert(dc) {
        //draw the green triangle
        var x1;
        var y1;
        var x2;
        var y2;
        var x3;
        var y3;
        var xCen = dc.getWidth() / 2;
        var yCen = dc.getHeight() / 2;

        x1 = xCen - (30 * g_ScaleFactorX).toNumber();
        y1 = yCen - (45 * g_ScaleFactorY).toNumber();
        x2 = xCen - (30 * g_ScaleFactorX).toNumber();
        y2 = yCen + (45 * g_ScaleFactorY).toNumber();
        x3 = xCen + (40 * g_ScaleFactorX).toNumber();
        y3 = yCen;
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.fillPolygon([ [x1, y1],
                         [x2, y2],
                         [x3, y3] ]);
//        dc.fillPolygon([ [xCen - 30, yCen - 45],
//                         [yCen - 30, yCen + 45],
//                         [xCen + 40, yCen] ]);

        x1 = xCen - (27 * g_ScaleFactorX).toNumber();
        y1 = yCen - (39 * g_ScaleFactorY).toNumber();
        x2 = yCen - (27 * g_ScaleFactorX).toNumber();
        y2 = yCen + (39 * g_ScaleFactorY).toNumber();
        x3 = xCen + (34 * g_ScaleFactorX).toNumber();
        y3 = yCen;
        dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_DK_GREEN);
        dc.fillPolygon([ [x1, y1],
                         [x2, y2],
                         [x3, y3] ]);
//        dc.fillPolygon([ [xCen - 27, yCen - 39],
//                         [xCen - 27, yCen + 39],
//                         [xCen + 34, yCen] ]);
    }

    function drawStopAlert(dc) {
        var x1;
        var y1;
        var x2;
        var y2;
        var x3;
        var y3;
        var x4;
        var y4;
        //draw the red square
        var xCen = dc.getWidth() / 2;
        var yCen = dc.getHeight() / 2;

        x1 = xCen - (45 * g_ScaleFactorX).toNumber();
        y1 = yCen - (45 * g_ScaleFactorY).toNumber();
        x2 = yCen - (45 * g_ScaleFactorX).toNumber();
        y2 = yCen + (45 * g_ScaleFactorY).toNumber();
        x3 = xCen + (45 * g_ScaleFactorX).toNumber();
        y3 = yCen + (45 * g_ScaleFactorY).toNumber();
        x4 = xCen + (45 * g_ScaleFactorX).toNumber();
        y4 = yCen - (45 * g_ScaleFactorY).toNumber();
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.fillPolygon([ [x1, y1],
                         [x2, y2],
                         [x3, y3],
                         [x4, y4] ]);
//        dc.fillPolygon([ [xCen - 45, yCen - 45],
//                         [xCen - 45, yCen + 45],
//                         [xCen + 45, yCen + 45],
//                         [xCen + 45, yCen - 45] ]);

        x1 = xCen - (42 * g_ScaleFactorX).toNumber();
        y1 = yCen - (42 * g_ScaleFactorY).toNumber();
        x2 = yCen - (42 * g_ScaleFactorX).toNumber();
        y2 = yCen + (42 * g_ScaleFactorY).toNumber();
        x3 = xCen + (42 * g_ScaleFactorX).toNumber();
        y3 = yCen + (42 * g_ScaleFactorY).toNumber();
        x4 = xCen + (42 * g_ScaleFactorX).toNumber();
        y4 = yCen - (42 * g_ScaleFactorY);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED);
        dc.fillPolygon([ [x1, y1],
                         [x2, y2],
                         [x3, y3],
                         [x4, y4] ]);
//        dc.fillPolygon([ [xCen - 42, yCen - 42],
//                         [xCen - 42, yCen + 42],
//                         [xCen + 42, yCen + 42],
//                         [xCen + 42, yCen - 42] ]);
    }

    function drawSmo2Alert(dc, text) {
        var font = Gfx.FONT_MEDIUM;
        var fgcolor = Gfx.COLOR_BLACK;
        var bgcolor = Gfx.COLOR_WHITE;
        var tWidth  = dc.getTextWidthInPixels(text, font);
        var tHeight = dc.getFontHeight(font);

        var bWidth  = tWidth + (14 * g_ScaleFactorX).toNumber();
        var bHeight = tHeight + (14* g_ScaleFactorY).toNumber();

        var bX = (dc.getWidth() - bWidth) / 2;
        var bY = (dc.getHeight() - bHeight) / 2;

        dc.setColor(bgcolor, bgcolor);
        dc.fillRectangle(bX, bY, bWidth, bHeight);

        dc.setColor(fgcolor, fgcolor);

        for (var i = 0; i < 3; ++i) {
            bX += i;
            bY += i;
            bWidth -= (2 * i);
            bHeight -= (2 * i);

            dc.drawRectangle(bX, bY, bWidth, bHeight);
        }

        var tX = dc.getWidth() / 2;
        var tY = dc.getHeight() / 2 - tHeight / 2;

        dc.setColor(fgcolor, Gfx.COLOR_TRANSPARENT);
        dc.drawText(tX, tY, font, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
}