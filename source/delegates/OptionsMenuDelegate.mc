using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;
using Toybox.Lang;
using Toybox.Graphics; // Needed for Picker title drawable





/**
 * Input Delegate for the Options Menu.
 * Handles selecting an option, launching the modern Picker.
 */
class OptionsMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {

        var id = item.getId();

        if ( id == :setDailyCount ) {

            System.println( "Setting Daily Count selected - using Picker" );
            
            var currentCount = Application.Storage.getValue( "dailyBreathCount" );
            
            if ( !(currentCount instanceof Lang.Number) ) {
                currentCount = 108; // Default
            }

            WatchUi.pushView( 
                new CountPickerView( "set daily count", currentCount ), 
                new DailyCountPickerDelegate(), 
                WatchUi.SLIDE_LEFT
            );
        }
    }

    function onBack() as Void {

        System.println( "Back pressed on options menu - Popping View" );
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}