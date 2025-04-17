using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;




class SessionMenuView extends WatchUi.Menu2 {

    function initialize( elapsedTime as Lang.Number, breathCount as Lang.Number ) {

        Menu2.initialize( { :title=>"now exhale..." } );


        addItem( new WatchUi.MenuItem( "Save Session",    "Log your data",           :save_session,    null ) );
        addItem( new WatchUi.MenuItem( "Resume Session",  "Continue your practice",  :return_session,  null ) );
        addItem( new WatchUi.MenuItem( "Discard Session", "End without saving",      :discard_session, null ) );

        setIcon( Rez.Drawables.session_menu_icon );
    }

    function onLayout(dc as Graphics.Dc) as Void {
        // Menu2 handles its own layout
    }

 }