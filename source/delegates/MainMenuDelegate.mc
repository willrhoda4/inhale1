using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Graphics; // Needed for Picker title drawable



/**
 * Input Delegate for the MainMenuView.
 * Updated to use modern Picker for Custom mode.
 */
class MainMenuDelegate extends WatchUi.Menu2InputDelegate {


    function initialize() {
        Menu2InputDelegate.initialize();
    }


    function onSelect( item as WatchUi.MenuItem ) as Void {

        var id = item.getId() as Lang.Symbol;
        
        System.println( "Menu item selected: " + id );

        if ( id == :daily || id == :freestyle ) {
           
           
            System.println( id + " mode selected - launching Timer" );
            

            var view     = new BreathCountView( id, null );
            var delegate = new BreathCountDelegate( view );
            
            WatchUi.pushView( view, delegate, WatchUi.SLIDE_LEFT );

        } else if ( id == :custom ) {

            System.println( "Custom mode selected - launching Picker" );

            var defaultCount = Application.Storage.getValue( "customBreathCount" );
            
            if ( !( defaultCount instanceof Lang.Number ) ) {
                defaultCount = 108; // Default
            }


            WatchUi.pushView(
                new CountPickerView( "set count", defaultCount ), 
                new CustomPickerDelegate(), 
                WatchUi.SLIDE_LEFT
            );

        } else if ( id == :freestyle ) {

            System.println( "Freestyle mode selected - launching timer" );

            var view     = new SessionView(     :freestyle, null );
            var delegate = new SessionDelegate(  view            );
            
            WatchUi.pushView( view, delegate, WatchUi.SLIDE_LEFT );

        } else if ( id == :options ) {
            
            System.println( "Options selected - launching Options Menu" );

            var view     = new OptionsMenuView(); // Now OptionsMenuView IS the Menu2
            var delegate = new OptionsMenuDelegate();
            
            WatchUi.pushView( view, delegate, WatchUi.SLIDE_LEFT );
        }
    }

    function onBack() as Void {

        System.println( "Back pressed on main menu - Exiting" );
        System.exit();
    }
}