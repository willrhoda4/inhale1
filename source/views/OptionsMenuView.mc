using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Lang;
using Toybox.Graphics;

/**
 * View class for the Options/Settings menu.
 * NOW EXTENDS Menu2 DIRECTLY.
 */
class OptionsMenuView extends WatchUi.Menu2 {

    /**
     * Constructor. Initializes the options menu.
     */
    function initialize() {
        
        // Call the parent Menu2's initialize
        Menu2.initialize( { :title=>"Options" } );
        
        loadMenu();
    }


    /**
     * Called when the View is shown. Reload the menu by creating a new one.
     */
    function onShow() as Void {

        Menu2.initialize( { :title=>"Options" } ); // Create a new Menu2
        
        loadMenu();
    }

    /**
     * Helper function to load the menu items.
     */
    function loadMenu() as Void {

        var dailyCount = Application.Storage.getValue( "dailyBreathCount" );
        
        if ( !(dailyCount instanceof Lang.Number) ) {
         
               dailyCount = 108; // Default
        }


        addItem( new WatchUi.MenuItem(
            "Daily Count",
            dailyCount.toString(),
            :setDailyCount,
            {}
        ) );
    }

    // We no longer need onUpdate or onLayout as Menu2 handles its own drawing.
}