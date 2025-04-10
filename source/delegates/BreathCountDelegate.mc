using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

/**
 * Input Delegate class for the BreathCount Timer.
 * No major changes needed yet for mode handling, as View holds the state.
 */
class BreathCountDelegate extends WatchUi.BehaviorDelegate {

    private var _view as BreathCountView; // Reference to our mode-aware view

    /**
     * Constructor.
     * @param view The BreathCountView instance this delegate manages.
     */
    function initialize(view as BreathCountView) {

        BehaviorDelegate.initialize();

        _view = view;
    }

    /**
     * Handle the START/STOP/ENTER button press.
     * Logic remains the same - delegates state changes to the view.
     */
    function onSelect() as Lang.Boolean {

        System.println( "Delegate: Select Pressed. isRunning: " + _view._isRunning + ", showResults: " + _view._showResults );
        
             if ( _view._isRunning   ) {  _view.stopTimer();  } 
        else if ( _view._showResults ) {  _view.resetTimer(); } 
        else                           {  _view.startTimer(); }  
        
        return true;
    }

    /**
     * Handle the BACK button press.
     * Pops the current view (timer view) returning to the previous one (main menu).
     */
    function onBack() as Lang.Boolean {

        System.println( "Back Pressed on Timer View - Popping View" );

        // Pop this view/delegate pair, returning to the main menu
        WatchUi.popView( WatchUi.SLIDE_RIGHT ); // Use opposite slide direction
        
        return true;
    }
}
