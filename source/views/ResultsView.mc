using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Lang;
using Toybox.Graphics;

/**
 * View class for the Options/Settings menu.
 * NOW EXTENDS Menu2 DIRECTLY.
 */
class ResultsView extends WatchUi.Menu2 {



    private var _MeditationView as MeditationView; // Holds the reference to the MeditationView
    /**
     * Constructor. Initializes the options menu.
     */
    function initialize( MeditationView as MeditationView) {


        _MeditationView = MeditationView; // Store the reference to the MeditationView 
        // Call the parent Menu2's initialize
        Menu2.initialize( { :title=>"Session Summary" } );
        
        loadMenu();
    }


    /**
     * Called when the View is shown. Reload the menu by creating a new one.
     */
    function onShow() as Void { 
        
        initialize( _MeditationView ); 
        
        vibrate( 2 );
        
    } 


    /**
     * Helper function to load the menu items.
     */
    function loadMenu() as Void {



        addItem( new WatchUi.MenuItem(
            formatTime( _MeditationView._elapsedTime ),
            "total time spent",
            null,
            {}
        ) );
    
        addItem( new WatchUi.MenuItem(
            _MeditationView._breathCount+" breaths",
            "total breath count",
            null,
            {}
        ) );

        addItem( new WatchUi.MenuItem(
            _MeditationView._breathRate.format("%.2f")+" bpm",
            "breaths per minute",
            null,
            {}
        ) );    

        addItem( new WatchUi.MenuItem(
            _MeditationView._maxHeartRate.format("%.2f")+" bpm",
            "max heart rate",
            null,
            {}
        ) );    
        addItem( new WatchUi.MenuItem(
            _MeditationView._avgHeartRate.format("%.2f")+" bpm",
            "average heart rate",
            null,
            {}
        ) );    
        addItem( new WatchUi.MenuItem(
            _MeditationView._minHeartRate.format("%.2f")+" bpm",
            "min heart rate",
            null,
            {}
        ) );    

        setIcon( Rez.Drawables.results_view_icon ); 
    }

    // We no longer need onUpdate or onLayout as Menu2 handles its own drawing.
}