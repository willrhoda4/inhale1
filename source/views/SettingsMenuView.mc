using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Lang;
using Toybox.Graphics;

/**
 * View class for the Options/Settings menu.
 * NOW EXTENDS Menu2 DIRECTLY.
 */
class SettingsMenuView extends WatchUi.Menu2 {

    /**
     * Constructor. Initializes the options menu.
     */
    function initialize() {
        
        // Call the parent Menu2's initialize
        Menu2.initialize( { :title=>"Settings" } );
        
        loadMenu();
    }


    /**
     * Called when the View is shown. Reload the menu by creating a new one.
     */
    function onShow() as Void {}


    /**
     * Helper function to load the menu items.
     */
    function loadMenu() as Void {

        var dailyCount = Application.Storage.getValue( "dailyMeditation"   );
        
        if ( !(dailyCount instanceof Lang.Number  ) ) { dailyCount = 108;  }

        var vibSetting = Application.Storage.getValue( "vibrationSetting"  );

        if ( !(vibSetting instanceof Lang.Boolean ) ) { vibSetting = true; }


        addItem( new WatchUi.MenuItem(
            "Daily Count",
            dailyCount.toString(),
            :setDailyCount,
            {}
        ) );

        addItem( new WatchUi.MenuItem(
            "Vibrations",
            vibSetting ? "will vibrate" : "won't vibrate",
            :setVibrationSetting,
            {}
        ) );



        setIcon( Rez.Drawables.options_menu_icon );
    }

    // We no longer need onUpdate or onLayout as Menu2 handles its own drawing.
}