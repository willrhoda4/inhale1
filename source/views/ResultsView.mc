using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;
using Toybox.Graphics;

class ResultsView extends WatchUi.View {

    private var _elapsedTime as Lang.Number;
    private var _breathCount as Lang.Number;
    private var _avgBreathRate as Lang.Float;  // Add this

    function initialize(elapsedTime as Lang.Number, breathCount as Lang.Number, avgBreathRate as Lang.Float) { //add avgBreathRate
        View.initialize();
        _elapsedTime = elapsedTime;
        _breathCount = breathCount;
        _avgBreathRate = avgBreathRate;
    }

    function onLayout(dc as Graphics.Dc) {

        setLayout([
            new WatchUi.Text({
                :text => "Session Results",
                :color => Graphics.COLOR_WHITE,
                :font => Graphics.FONT_LARGE,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 20,
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            }),
            new WatchUi.Text({
                :text => "Time:",
                :color => Graphics.COLOR_WHITE,
                :font => Graphics.FONT_MEDIUM,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 70,
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            }),
            new WatchUi.Text({
                :text => formatTime(_elapsedTime),  // Use helper
                :color => Graphics.COLOR_YELLOW,
                :font => Graphics.FONT_MEDIUM,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 100,
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            }),
            new WatchUi.Text({
                :text => "Breaths:",
                :color => Graphics.COLOR_WHITE,
                :font => Graphics.FONT_MEDIUM,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 130,
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            }),
            new WatchUi.Text({
                :text => _breathCount.toString(),
                :color => Graphics.COLOR_YELLOW,
                :font => Graphics.FONT_MEDIUM,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 160,
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            }),
             new WatchUi.Text({  //display average breath rate.
                :text => "Avg Rate:",
                :color => Graphics.COLOR_WHITE,
                :font => Graphics.FONT_MEDIUM,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 190,
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            }),
            new WatchUi.Text({
                :text => _avgBreathRate.format("%.2f") + " bpm",
                :color => Graphics.COLOR_YELLOW,
                :font => Graphics.FONT_MEDIUM,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 220,
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            }),
            new WatchUi.Text({
                :text => "Press BACK to return",
                :color => Graphics.COLOR_DK_GRAY,
                :font => Graphics.FONT_SMALL,
                :locX => WatchUi.LAYOUT_HALIGN_CENTER,
                :locY => 270,  // Adjust as needed
                :justification => Graphics.TEXT_JUSTIFY_CENTER
            })
        ]);
    }

    function onShow() {
        View.onShow();
    }

    function onUpdate(dc as Graphics.Dc) {
        View.onUpdate(dc);
    }
}