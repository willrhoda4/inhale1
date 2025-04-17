using Toybox.WatchUi;



/**
    * Creates the main menu for the application.
    * @return WatchUi.Menu2 The main menu object
    */
function makeMainMenu() as WatchUi.Menu2 {

        var menu = new WatchUi.Menu2( {:title=>"Select Mode" } );

            menu.addItem( new WatchUi.MenuItem( "Daily",     "Use Stored Count", :daily,     {} ));
            menu.addItem( new WatchUi.MenuItem( "Custom",    "Set Count First",  :custom,    {} ) );
            menu.addItem( new WatchUi.MenuItem( "Freestyle", "Set Count After",  :freestyle, {} ) );
            menu.addItem( new WatchUi.MenuItem( "Options",   "Settings",         :options,   {} ) );

            menu.setIcon( Rez.Drawables.main_menu_icon );
        return menu;
}
