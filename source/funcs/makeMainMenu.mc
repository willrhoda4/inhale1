using Toybox.WatchUi;



/**
    * Creates the main menu for the application.
    * @return WatchUi.Menu2 The main menu object
    */
function makeMainMenu() as WatchUi.Menu2 {

        var menu = new WatchUi.Menu2( {:title=>"Select Mode" } );

            menu.addItem( new WatchUi.MenuItem( "Daily",     "used stored count", :daily,     {} ));
            menu.addItem( new WatchUi.MenuItem( "Custom",    "set count first",   :custom,    {} ) );
            menu.addItem( new WatchUi.MenuItem( "Freestyle", "set count after",   :freestyle, {} ) );
            menu.addItem( new WatchUi.MenuItem( "Settings",  "your preferences",  :options,   {} ) );

            menu.setIcon( Rez.Drawables.main_menu_icon );
        return menu;
}
