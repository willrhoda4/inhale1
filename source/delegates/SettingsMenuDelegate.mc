using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;
using Toybox.Lang;
using Toybox.Graphics; // Needed for Picker title drawable





/**
 * Input Delegate for the Options Menu.
 * Handles selecting an option, launching the modern Picker.
 */
class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {

        var id = item.getId();

        if ( id == :setDailyCount ) {

            System.println( "Setting Daily Count selected - using Picker" );
            
            var currentCount = Application.Storage.getValue( "dailyMeditation" );
            
            if ( !(currentCount instanceof Lang.Number) ) {
                currentCount = 108; // Default
            }

            WatchUi.pushView( 
                new CountPickerView( "set count", currentCount ), 
                new DailyCountPickerDelegate(), 
                WatchUi.SLIDE_LEFT
            );
        
        
        } else if ( id == :setVibrationSetting ) {

            System.println( "Attempting to update vibration setting." );

            var currVibSetting = Application.Storage.getValue( "vibrationSetting" );

            if ( !( currVibSetting instanceof Lang.Boolean ) ) {

                currVibSetting = false;
            }

            Application.Storage.setValue( "vibrationSetting", !currVibSetting );

            var view     = new SettingsMenuView(); // Now OptionsMenuView IS the Menu2
            var delegate = new SettingsMenuDelegate();
            
            WatchUi.popView( WatchUi.SLIDE_IMMEDIATE );
            WatchUi.pushView( view, delegate, WatchUi.SLIDE_IMMEDIATE );

        } 
    }

    function onBack() as Void {

        System.println( "Back pressed on options menu - Popping View" );
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}