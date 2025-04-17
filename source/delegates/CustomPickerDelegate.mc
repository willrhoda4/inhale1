using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

/**
 * Delegate for handling results from the modern Picker used
 * to set the breath count for a Custom session.
 */
class CustomPickerDelegate extends WatchUi.PickerDelegate {

    
    function initialize() {
        PickerDelegate.initialize();
    }

    /**
     * Called when the user accepts a selection from the Picker.
     * Launches the BreathCountView with the selected count.
     * @param values An Array of selected values
     * @return True if the Picker should exit, false otherwise
     */
    function onAccept(values as Lang.Array) as Lang.Boolean {

        var selectedValue = values[0]; // Get the number from the first (only) factory

        if ( selectedValue instanceof Lang.Number ) {

            System.println( "Custom Count picked: " + selectedValue );

            Application.Storage.setValue( "customBreathCount", selectedValue );

            var options  =     { :breathCount => selectedValue };
            var view     = new SessionView( :custom, options );
            var delegate = new SessionDelegate( view );

            // Use pushView as requested (Back from timer goes to picker, then menu)
            WatchUi.pushView( view, delegate, WatchUi.SLIDE_LEFT );
            
            return true; // Exit picker context after pushing new view
        
        } else {
        
            System.println( "Error: Invalid type picked: " + selectedValue );
            WatchUi.popView( WatchUi.SLIDE_RIGHT ); // Pop picker on error
            
            return true; // Exit picker context
        }
    }

    /**
     * Called when the user cancels the Picker.
     * @return True if the Picker should exit, false otherwise
     */
    function onCancel() as Lang.Boolean {

        System.println( "Custom Picker cancelled" );
        WatchUi.popView( WatchUi.SLIDE_RIGHT ); // Pop picker view
        return true; // Exit picker context
    }
}