using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Lang;
using Toybox.Graphics;

/**
 * View class for the Options/Settings menu.
 * NOW EXTENDS Menu2 DIRECTLY.
 */
class ResultsView extends WatchUi.Menu2 {



    private var _breathCountView as BreathCountView; // Holds the reference to the BreathCountView
    /**
     * Constructor. Initializes the options menu.
     */
    function initialize( breathCountView as BreathCountView) {


        _breathCountView = breathCountView; // Store the reference to the BreathCountView 
        // Call the parent Menu2's initialize
        Menu2.initialize( { :title=>"Session Summary" } );
        
        loadMenu();
    }


    /**
     * Called when the View is shown. Reload the menu by creating a new one.
     */
    function onShow() as Void { initialize( _breathCountView ); } 


    /**
     * Helper function to load the menu items.
     */
    function loadMenu() as Void {



        addItem( new WatchUi.MenuItem(
            formatTime( _breathCountView._elapsedTime ),
            "total time spent",
            null,
            {}
        ) );
    
        addItem( new WatchUi.MenuItem(
            _breathCountView._breathCount+" breaths",
            "total breath count",
            null,
            {}
        ) );

        addItem( new WatchUi.MenuItem(
            _breathCountView._breathRate.format("%.2f")+" bpm",
            "breaths per minute",
            null,
            {}
        ) );    

        setIcon( Rez.Drawables.results_view_icon ); 
    }

    // We no longer need onUpdate or onLayout as Menu2 handles its own drawing.
}