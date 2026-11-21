using Toybox.WatchUi as Ui;
using Toybox.Application as App;
class ColourMenu extends Ui.Menu2 {
    function initialize() {
        Menu2.initialize({:title=>"TACTICAL COLOURS"});
        addItem(new Ui.MenuItem("Time", null, "time", null));
        addItem(new Ui.MenuItem("Date", null, "date", null));
        addItem(new Ui.MenuItem("Battery", null, "battery", null));
        addItem(new Ui.MenuItem("Accent lines", null, "accent", null));
    }
}
class ColourMenuDelegate extends Ui.Menu2InputDelegate {
    function initialize() { Menu2InputDelegate.initialize(); }
    function onSelect(item) {
        var key = item.getId();
        Ui.pushView(new PaletteMenu(), new PaletteDelegate(key), Ui.SLIDE_LEFT);
    }
}
class PaletteMenu extends Ui.Menu2 {
    function initialize() {
        Menu2.initialize({:title=>"SELECT COLOUR"});
        addItem(new Ui.MenuItem("White", null, 0xFFFFFF, null));
        addItem(new Ui.MenuItem("Orange", null, 0xFF8800, null));
        addItem(new Ui.MenuItem("Red", null, 0xFF0000, null));
        addItem(new Ui.MenuItem("Green", null, 0x00FF00, null));
        addItem(new Ui.MenuItem("Cyan", null, 0x00FFFF, null));
        addItem(new Ui.MenuItem("Yellow", null, 0xFFFF00, null));
        addItem(new Ui.MenuItem("Blue", null, 0x0088FF, null));
        addItem(new Ui.MenuItem("Grey", null, 0xAAAAAA, null));
    }
}
class PaletteDelegate extends Ui.Menu2InputDelegate {
    var _key;
    function initialize(key) { Menu2InputDelegate.initialize(); _key = key; }
    function onSelect(item) {
        App.Storage.setValue(_key, item.getId());
        Ui.popView(Ui.SLIDE_RIGHT);
    }
}