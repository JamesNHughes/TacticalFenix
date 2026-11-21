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
        line(dc,sx,sy,76,31,204,31,ac,2);
        line(dc,sx,sy,76,31,65,43,ac,2);
        line(dc,sx,sy,204,31,215,43,ac,2);
        line(dc,sx,sy,65,43,76,55,ac,2);
        line(dc,sx,sy,215,43,204,55,ac,2);
        line(dc,sx,sy,76,55,204,55,ac,2);
        dc.setColor(bc,Gfx.COLOR_TRANSPARENT);
        var bat = Sys.getSystemStats().battery.toNumber();
        dc.drawRectangle((83*sx).toNumber(),(37*sy).toNumber(),(29*sx).toNumber(),(13*sy).toNumber());
        dc.fillRectangle((113*sx).toNumber(),(41*sy).toNumber(),(3*sx).toNumber(),(5*sy).toNumber());
        dc.fillRectangle((85*sx).toNumber(),(39*sy).toNumber(),((25*bat/100)*sx).toNumber(),(9*sy).toNumber());
        dc.drawText((123*sx).toNumber(),(32*sy).toNumber(),Gfx.FONT_MEDIUM,bat.format("%d")+"%",Gfx.TEXT_JUSTIFY_LEFT);
        dc.setColor(tc,Gfx.COLOR_TRANSPARENT);
        dc.drawText((140*sx).toNumber(),(77*sy).toNumber(),Gfx.FONT_NUMBER_THAI_HOT,(timeText),Gfx.TEXT_JUSTIFY_CENTER);
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