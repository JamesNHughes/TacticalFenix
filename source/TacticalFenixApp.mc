using Toybox.Application as App;
using Toybox.WatchUi as Ui;
class TacticalFenixApp extends App.AppBase {
    function initialize() { AppBase.initialize(); }
    function getInitialView() { return [new TacticalFace()]; }
    function getSettingsView() { return [new ColourMenu(), new ColourMenuDelegate()]; }
}