using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

class ResultsDelegate extends WatchUi.Menu2InputDelegate { 

    private var _mode as Lang.Symbol;

    function initialize( mode as Lang.Symbol ) {
        _mode = mode;
        System.println( "ResultsDelegate initialized with mode: " + _mode );
        Menu2InputDelegate.initialize();
    }

    function onBack() as Void {

        System.println("Back Pressed on Results View - Returning to Main Menu");

        WatchUi.popView( WatchUi.SLIDE_RIGHT     );  // Pop the ResultsView
        WatchUi.popView( WatchUi.SLIDE_IMMEDIATE );  // Pop the SessionMenuView
        WatchUi.popView( WatchUi.SLIDE_IMMEDIATE );  // Pop the SessionView

        if ( _mode == :custom || _mode == :freestyle ) {
            WatchUi.popView( WatchUi.SLIDE_IMMEDIATE ); // Pop the Picker
        }
    }
}
