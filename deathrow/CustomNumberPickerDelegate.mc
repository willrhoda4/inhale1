using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

/**
 * Delegate for the Custom NumberPicker.
 * CORRECTED: onNumberPicked signature and internal type check.
 * CORRECTED: Using pushView based on user feedback.
 */
class CustomNumberPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    /**
     * Called when the user confirms a number.
     * CORRECTED: Signature uses 'value as Object?'
     * @param value The value picked (expected Number, but signature is Object?)
     * @return Boolean True to indicate the picker should exit.
     */
    // --- CORRECTED SIGNATURE ---
    function onNumberPicked(value) as Lang.Boolean {
         // --- ADD TYPE CHECK ---
        if (value instanceof Lang.Number) {
            var numericValue = value as Lang.Number; // Cast to Number
            System.println("Custom Count picked: " + numericValue);

            var options = { :breathCount => numericValue };
            var view = new BreathCountView(:custom, options);
            var delegate = new BreathCountDelegate(view);

            // --- USING pushView as requested ---
            // This means Back from timer goes here (picker context), then picker pops to main menu.
            WatchUi.pushView(view, delegate, WatchUi.SLIDE_LEFT);

            // Since we pushed a new view, the picker delegate context might be lost
            // when the user eventually backs out of the timer view.
            // Returning true might not be strictly necessary if pushView replaces the delegate stack,
            // but it's good practice.
            return true; // Indicate picker logic is done.
        } else {
             System.println("Error: Invalid type picked from NumberPicker: " + value);
             WatchUi.popView(WatchUi.SLIDE_RIGHT); // Pop picker
             return true; // Exit picker
        }
    }

     /**
      * Called when the user cancels the NumberPicker.
      */
     function onCancel() as Lang.Boolean {
        System.println("Custom Number Picker cancelled");
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
     }
}
