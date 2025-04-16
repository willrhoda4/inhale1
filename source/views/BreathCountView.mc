using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Timer;
using Toybox.Lang;
using Toybox.System;
using Toybox.Application;
using Toybox.ActivityRecording;
using Toybox.FitContributor;


/**
 * Main View class for the BreathCount Timer.
 * Updated constructor to accept optional parameters (like breath count for custom).
 */
class BreathCountView extends WatchUi.View {

    // --- Member Variables ---
    public  var _mode         as Lang.Symbol;
    public  var _breathCount  as Lang.Number; // Now set based on mode and options
    public  var _session      as ActivityRecording.Session or Null; // Nullable type
    public  var _elapsedTime  as Lang.Number; // Elapsed time in milliseconds

    private var _timer        as Timer.Timer or Null;

    public var _devFieldBreathCount as FitContributor.Field or Null;
    public var _devFieldBreathRate  as FitContributor.Field or Null;
    
    const      DEFAULT_COUNT = 108; // Default breath count for daily mode


    /**
     * Constructor. Accepts mode and optional dictionary for parameters.
     * @param mode Symbol representing the selected mode (:daily, :custom, :freestyle)
     * @param options Dictionary? Optional parameters (e.g., {:breathCount => value})
     */
    // --- UPDATED CONSTRUCTOR SIGNATURE ---
    function initialize( mode as Lang.Symbol, options as Lang.Dictionary? ) {

        View.initialize();

        _mode                = mode;
        _timer               = null;
        _devFieldBreathCount = null;
        _devFieldBreathRate  = null;
        _elapsedTime         = 0; // Initialize elapsed time

        // Initialize breath count based on mode and options
        if ( _mode == :daily ) {

            // get breath count from storage or set default (108):
            var storedCount = Application.Storage.getValue("dailyBreathCount");

            _breathCount = storedCount instanceof Lang.Number ? storedCount : DEFAULT_COUNT; 

            System.println( "Daily mode breath count: " + _breathCount );

        
        } else if ( _mode == :custom ) {

            // Get breath count from the options dictionary passed in
            if (    options != null 
                 && options.hasKey( :breathCount ) 
                 && options[        :breathCount ] instanceof Lang.Number
               
               ) {  _breathCount = options[ :breathCount ]; } 
            
            else {
                    _breathCount = DEFAULT_COUNT;
                    System.println( "Warning: Custom mode started without valid breath count in options." );
            }

            System.println( "Custom mode breath count: " + _breathCount );

        } else if ( _mode == :freestyle ) {

             _breathCount = 0; // Will be set after timer stops
            
             System.println( "Freestyle mode - breath count TBD" );

        } else {

             _breathCount = DEFAULT_COUNT; // Fallback default

             System.println( "Warning: Unknown mode, using default count 108" );
        }
    }




    // --- UI Timer Management ---
    private function startUiTimer() as Void {
       
        if ( _timer == null) { 
            
            _timer = new Timer.Timer();
        
            _timer.start( method( :updateUi ), 1000, true );
        
            System.println( "UI Update Timer Started" );
        }
    }

    private function stopUiTimer() as Void {

        if ( _timer != null) {

            _timer.stop();

            _timer = null;

            System.println( "UI Update Timer Stopped" );
        }
    }

    function updateUi () as Void {

        WatchUi.requestUpdate();
    }



    function onLayout( dc as Graphics.Dc ) as Void { }
    



    
    
    function onUpdate( dc as Graphics.Dc ) as Void {

        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_BLACK );

        dc.clear();


        if ( _session != null ) {

            var info = Activity.getActivityInfo();

            if ( info != null && info.timerTime != null ) {

                _elapsedTime = info.timerTime;
            }
        }

        var screenWidth    = dc.getWidth(); 
        var screenHeight   = dc.getHeight(); 
        var centerX        = screenWidth / 2;

        var timeStr        = formatTime( _elapsedTime );
        var timeFont       = Graphics.FONT_LARGE;
        var timeFontHeight = Graphics.getFontHeight( timeFont );



        dc.drawText( 
            centerX, 
            screenHeight / 2 - ( timeFontHeight / 2 ), 
            timeFont, 
            timeStr, 
            Graphics.TEXT_JUSTIFY_CENTER 
        );

        var inProgress = _session != null && _session.isRecording();
        var promptText = inProgress ? "Press SELECT to stop" : "Press SELECT to start";
        
        dc.drawText( 
            centerX, 
            ( screenHeight * 3 ) / 4, 
            Graphics.FONT_XTINY, 
            promptText, 
            Graphics.TEXT_JUSTIFY_CENTER 
        );
    }



    function updateView() as Void {

        WatchUi.requestUpdate();
    }






   function startMeditation() as Void {

        if (_session == null) { // Only start if no session exists

            var sessionData = null; 
            sessionData = initiateSession();

             if ( sessionData != null ) {

                 _session             = sessionData[ :session          ] as ActivityRecording.Session;
                 _devFieldBreathCount = sessionData[ :fieldBreathCount ] as FitContributor.Field;
                 _devFieldBreathRate  = sessionData[ :fieldBreathRate  ] as FitContributor.Field;
                 
                 startUiTimer(); // Start UI updates
                 WatchUi.requestUpdate(); // Initial update
             
             } else {

                 // Handle error starting session (e.g., show message to user)
                 System.println( "Failed to get session data from startSession function." );
             }
        } else {
            
            System.println( "Warning: startTimer called but session already exists." );
        }
    }



    function pauseMeditation() as Void {

        if (_session != null) { // Only stop if session exists

            _session.stop(); // Stop the session
            stopUiTimer();   // Stop UI updates
            WatchUi.requestUpdate(); // Update the view
        } else {

            System.println( "Warning: pauseMeditation called but no session exists." );
        }
    }



    function resumeMeditation() as Void {

        if (_session != null) { // Only start if session exists

            _session.start(); // Start the session
            startUiTimer();   // Start UI updates
            WatchUi.requestUpdate(); // Update the view

        } else {

            System.println( "Warning: resumeMeditation called but no session exists." );
        }
    }

    

    // Save the session
    function saveSession() as Void {


        System.println("Saving session...");

        stopUiTimer(); // Ensure UI timer is stopped
        
        if (_session != null) {
        
        
        
             var avgBreathRate = ( _elapsedTime > 0 && _breathCount > 0 ) 
                                        ? ( _breathCount.toFloat() / ( _elapsedTime / 1000 / 60.0f ) ) 
                                        : 0.0f;

            // Set Developer Data Fields
            // Add null checks for field objects before calling setData
            if ( _devFieldBreathCount != null ) { _devFieldBreathCount.setData( _breathCount ); }
            else { System.println( "Error: Breath Count Field is null" ); }
            
            if ( _devFieldBreathRate != null ) { _devFieldBreathRate.setData( avgBreathRate ); }
            else { System.println( "Error: Breath Rate Field is null" ); }

            // Stop (if paused) and Save
            if (!_session.isRecording()) { // If it was paused (_isStopping was true)
                 _session.stop(); // Ensure session is stopped before saving
            }

            System.println("count: " + _breathCount);
            System.println("rate: " + avgBreathRate);
            
            
            var saveStatus = _session.save();

            System.println("Session Saved: "+saveStatus);

        } else { System.println( "Error: No active session to save." ); }
         // Clear session state
         _session = null; _devFieldBreathCount = null; _devFieldBreathRate = null;
    }

    // Discard the session
    function discardSession() as Void {
        
        System.println( "Discarding session..." );
        
        stopUiTimer();
        
        if ( _session != null ) {

             _session.discard();
             System.println( "Session Discarded." );
        } else { System.println( "No session object exists to discard." ); }
        // Clear session state
        _session = null; _devFieldBreathCount = null; _devFieldBreathRate = null; 
    }





    function onShow() as Void { if ( _session != null ) { resumeMeditation(); } }
    

    function onHide() as Void {}

}