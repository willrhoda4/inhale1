using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

class ResultsViewDelegate extends WatchUi.BehaviorDelegate {


    private var _mode as Lang.Symbol;

    function initialize( mode as Lang.Symbol ) {
        BehaviorDelegate.initialize();

        _mode = mode;

    }

    function onBack() as Lang.Boolean {

        System.println("Back Pressed on Results View - Returning to Main Menu");

        WatchUi.popView( WatchUi.SLIDE_RIGHT     );  // Pop the ResultsView
        WatchUi.popView( WatchUi.SLIDE_IMMEDIATE );  // Pop the ResultsView
        WatchUi.popView( WatchUi.SLIDE_IMMEDIATE );  // Pop the ResultsView

        if ( _mode == :custom || _mode == :freestyle ) {
            WatchUi.popView( WatchUi.SLIDE_IMMEDIATE ); // Pop the Picker
        }


        return true;
    }

    // Add these functions for scroll navigation if needed.
    function onNextPage() as Lang.Boolean {
        System.println("Next Page (Down) on Results View");
        // Implement scrolling logic here if your ResultsView is scrollable
        // You might use a Ui.Container in your ResultsView and change its scroll position
        return true;
    }

    function onPreviousPage() as Lang.Boolean {
        System.println("Previous Page (Up) on Results View");
        // Implement scrolling logic here
        return true;
    }
}
