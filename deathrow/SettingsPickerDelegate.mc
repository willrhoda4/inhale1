using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;

/**
 * Delegate for handling results from the modern Picker used
 * to set the Daily Breath Count in options.
 */
class SettingsPickerDelegate extends WatchUi.PickerDelegate {

    /**
     * Constructor.
     */
    function initialize() {
        PickerDelegate.initialize();
    }

    /**
     * Called when the user accepts a selection from the Picker.
     * @param values An Array of selected values (one for each factory/pattern element)
     * @return True if the Picker should exit, false otherwise
     */
    function onAccept(values as Lang.Array) as Lang.Boolean {
        // Our picker pattern has only one element: the NumberFactory.
        // The selected value is the first element in the 'values' array.
        var selectedValue = values[0];

        if (selectedValue instanceof Lang.Number) {
            System.println("Daily Count picked: " + selectedValue);
            // Save the selected value to persistent storage
            Application.Storage.setValue("dailyBreathCount", selectedValue);
        } else {
            System.println("Error: Invalid type picked: " + selectedValue);
            // Handle error appropriately, maybe show a message later
        }

        // Pop the picker view to return to the options menu
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true; // Indicate picker should exit
    }

    /**
     * Called when the user cancels the Picker (e.g., presses Back).
     * @return True if the Picker should exit, false otherwise
     */
    function onCancel() as Lang.Boolean {
        System.println("Settings Picker cancelled");
        // Pop the picker view
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true; // Indicate picker should exit
    }
}
