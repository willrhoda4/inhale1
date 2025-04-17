using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

/**
 * Input Delegate class for the Meditation Timer.
 * No major changes needed yet for mode handling, as View holds the state.
 */
class MeditationDelegate extends WatchUi.BehaviorDelegate {

    private var _view as MeditationView; // Reference to our mode-aware view

    /**
     * Constructor.
     * @param view The MeditationView instance this delegate manages.
     */
    function initialize( view as MeditationView ) {

        BehaviorDelegate.initialize();

        _view = view;
    }


    function isRecording() as Lang.Boolean {

         var recording = false;
        
        if ( _view._session != null ) { recording =_view._session.isRecording(); }
        
        return recording;
    }

    function loadSessionMenu() as Void {

        _view.pauseMeditation();
        
        var sessionMenuView = new SessionMenuView();
        
        WatchUi.pushView( 
            sessionMenuView, 
            new SessionMenuDelegate( _view ), 
            WatchUi.SLIDE_LEFT 
        );
    }


    /**
     * Handle the START/STOP/ENTER button press.
     * Logic remains the same - delegates state changes to the view.
     */
    function onSelect() as Lang.Boolean {

        System.println( "Delegate: Select Pressed." );

        if ( isRecording() ) { loadSessionMenu();       }

        else                 { 
            
            _view.startMeditation(); 
          
            WatchUi.pushView( 
                new InhaleView(), 
                new InhaleDelegate(), 
                WatchUi.SLIDE_LEFT 
            );

        }

        return true;
    }    


    /**
     * Handle the BACK button press.
     * Pops the current view (timer view) returning to the previous one (main menu).
     */
    function onBack() as Lang.Boolean {

        System.println( "Back Pressed on Timer View - Popping View" );

        if ( isRecording() ) { loadSessionMenu(); }
        else                 { 
            
            _view.pauseMeditation(); 
            WatchUi.popView( WatchUi.SLIDE_RIGHT );
        }        
        return true;
    }
}
