using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Greg;
using Toybox.Application as App;
class TacticalFace extends Ui.WatchFace {
    var DAYS = ["SUN","MON","TUE","WED","THU","FRI","SAT"];
    var MONTHS = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"];
    function initialize() { WatchFace.initialize(); }
    function colour(key, fallback) {
        var v = App.Storage.getValue(key);
        return v == null ? fallback : v;
    }
    function onUpdate(dc) {
        var w = dc.getWidth();
        var h = dc.getHeight();
        var sx = w.toFloat() / 280.0;
        var sy = h.toFloat() / 280.0;
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        var tc = colour("time", 0xFFFFFF);
        var dt = colour("date", 0xFFFFFF);
        var bc = colour("battery", 0xFFFFFF);
        var ac = colour("accent", 0xFF8800);
        var now = Sys.getClockTime();
        var today = Greg.info(Time.now(), Time.FORMAT_SHORT);
        var timeText = now.hour.format("%02d") + ":" + now.min.format("%02d");
        var dateText = DAYS[today.day_of_week-1] + " " + today.day.format("%02d") + " " + MONTHS[today.month-1];
        // Enlarged battery group with a shared vertical centre; no surrounding frame.
        var bat = Sys.getSystemStats().battery.toNumber();
        var batteryText = bat.format("%d") + "%";
        var batteryFont = Gfx.FONT_LARGE;
        var batteryTextWidth = dc.getTextWidthInPixels(batteryText, batteryFont);
        var batteryTextHeight = dc.getFontHeight(batteryFont);
        var iconW = (42*sx).toNumber();
        var iconH = (21*sy).toNumber();
        var gap = (11*sx).toNumber();
        var tipW = (5*sx).toNumber();
        var groupW = iconW + tipW + gap + batteryTextWidth;
        var iconX = ((w-groupW)/2).toNumber();
        var centreY = (46*sy).toNumber();
        var iconY = (centreY-iconH/2).toNumber();
        dc.setColor(bc,Gfx.COLOR_TRANSPARENT);
        // Battery symbol only: outline is part of the battery, not a panel.
        dc.setPenWidth(2);
        dc.drawRectangle(iconX,iconY,iconW,iconH);
        dc.fillRectangle(iconX+iconW,iconY+(iconH/3).toNumber(),tipW,(iconH/3).toNumber());
        var fillW = ((iconW-6)*bat/100).toNumber();
        if (fillW > 0) {
            dc.fillRectangle(iconX+3,iconY+3,fillW,iconH-6);
        }
        dc.drawText(iconX+iconW+tipW+gap,
                    centreY-(batteryTextHeight/2).toNumber(),
                    batteryFont,batteryText,Gfx.TEXT_JUSTIFY_LEFT);
        dc.setColor(tc,Gfx.COLOR_TRANSPARENT);
        dc.drawText((140*sx).toNumber(),(77*sy).toNumber(),Gfx.FONT_NUMBER_HOT,(timeText),Gfx.TEXT_JUSTIFY_CENTER);
        line(dc,sx,sy,29,166,251,166,ac,3);
        dc.setColor(dt,Gfx.COLOR_TRANSPARENT);
        dc.drawText((140*sx).toNumber(),(193*sy).toNumber(),Gfx.FONT_LARGE,dateText,Gfx.TEXT_JUSTIFY_CENTER);
        line(dc,sx,sy,76,244,101,244,ac,2);
        line(dc,sx,sy,101,244,111,251,ac,2);
        line(dc,sx,sy,111,251,169,251,ac,2);
        line(dc,sx,sy,169,251,179,244,ac,2);
        line(dc,sx,sy,179,244,204,244,ac,2);
    }
    function line(dc,sx,sy,x1,y1,x2,y2,c,thick) {
        dc.setColor(c,Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(thick);
        dc.drawLine((x1*sx).toNumber(),(y1*sy).toNumber(),(x2*sx).toNumber(),(y2*sy).toNumber());
    }
}