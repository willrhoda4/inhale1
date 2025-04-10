using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Timer;
using Toybox.Lang;
using Toybox.System;
using Toybox.Application;

/**
 * Main View class for the BreathCount Timer.
 * Updated constructor to accept optional parameters (like breath count for custom).
 */
class BreathCountView extends WatchUi.View {

    // --- Member Variables ---
    private var _mode        as Lang.Symbol;
    private var _breathCount as Lang.Number; // Now set based on mode and options
    private var _timer       as Timer.Timer?;
    private var _elapsedTime =  0;
    public  var _isRunning   =  false;
    public  var _showResults =  false;
    private var _resultRate  =  0.0f;



    /**
     * Constructor. Accepts mode and optional dictionary for parameters.
     * @param mode Symbol representing the selected mode (:daily, :custom, :freestyle)
     * @param options Dictionary? Optional parameters (e.g., {:breathCount => value})
     */
    // --- UPDATED CONSTRUCTOR SIGNATURE ---
    function initialize( mode as Lang.Symbol, options as Lang.Dictionary? ) {

        View.initialize();

        _mode = mode;

        System.println( "BreathCountView initialized with mode: " + _mode );

        // Initialize breath count based on mode and options
        if ( _mode == :daily ) {

            var storedCount = Application.Storage.getValue("dailyBreathCount");

            if ( storedCount instanceof Lang.Number ) { _breathCount = storedCount; }
            
            else                                      { _breathCount = 108; 
                                                        Application.Storage.setValue( "dailyBreathCount", _breathCount ); 
                                                      }

            System.println( "Daily mode breath count: " + _breathCount );

        } else if ( _mode == :custom ) {

            // Get breath count from the options dictionary passed in
            if (    options != null 
                 && options.hasKey(:breathCount) 
                 && options[:breathCount] instanceof Lang.Number
               
               ) {  _breathCount = options[:breathCount]; } 
            
            else {
                    _breathCount = 1; // Fallback if options are missing/invalid
                    System.println( "Warning: Custom mode started without valid breath count in options." );
            }

            System.println( "Custom mode breath count: " + _breathCount );

        } else if ( _mode == :freestyle ) {

             _breathCount = 0; // Will be set after timer stops
            
             System.println( "Freestyle mode - breath count TBD" );

        } else {

             _breathCount = 108; // Fallback default

             System.println( "Warning: Unknown mode, using default count 108" );
        }
    }

    // ... (onLayout, onShow, onHide, onUpdate remain the same as previous version) ...
    function onLayout( dc as Graphics.Dc ) as Void { }
    

    function onShow() as Void { 
        
        _timer = new Timer.Timer(); 
        
    }
    

    function onHide() as Void { 
        
        if (_timer != null ) { _timer.stop(); } 
        
        _timer = null; 
        
    }



    
    
    function onUpdate( dc as Graphics.Dc ) as Void {

        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_BLACK );

        dc.clear();
        
        var screenWidth  = dc.getWidth(); 
        var screenHeight = dc.getHeight(); 
        var centerX      = screenWidth / 2;

        if ( _showResults ) {

            var durationStr = formatTime( _elapsedTime );

            dc.drawText( centerX,   screenHeight      / 5, Graphics.FONT_MEDIUM, "Time: " + durationStr,                         Graphics.TEXT_JUSTIFY_CENTER );
            dc.drawText( centerX, ( screenHeight * 2) / 5, Graphics.FONT_MEDIUM, "Rate: " + _resultRate.format("%.2f") + " bpm", Graphics.TEXT_JUSTIFY_CENTER );
            dc.drawText( centerX, ( screenHeight * 3) / 5, Graphics.FONT_SMALL,  "(" + _breathCount + " breaths)",               Graphics.TEXT_JUSTIFY_CENTER );
            dc.drawText( centerX, ( screenHeight * 4) / 5, Graphics.FONT_XTINY,  "Press START to reset",                         Graphics.TEXT_JUSTIFY_CENTER );
        }
         else {
        
            var timeStr        = formatTime( _elapsedTime ); 
            var timeFont       = Graphics.FONT_LARGE; 
            var timeFontHeight = Graphics.getFontHeight( timeFont );
            
            dc.drawText( centerX, screenHeight / 2 - ( timeFontHeight / 2 ), timeFont, timeStr, Graphics.TEXT_JUSTIFY_CENTER );

            var promptText = _isRunning ? "Press START to stop" : "Press START to begin";
            
            dc.drawText( centerX, ( screenHeight * 3 ) / 4, Graphics.FONT_XTINY, promptText, Graphics.TEXT_JUSTIFY_CENTER );
        }
    }


    // ... (startTimer, stopTimer, resetTimer, timerCallback, formatTime remain the same) ...
    function startTimer() as Void { 
        
        if ( !_isRunning && _timer != null ) {
            
             _isRunning   = true; 
             _showResults = false; 
             _elapsedTime = 0;
             
             _timer.start( method( :timerCallback ), 1000, true ); 
             
             System.println( "Timer Started (Mode: " + _mode + ") "); 
             WatchUi.requestUpdate(); 
        } 
    }


    function stopTimer() as Void { 
        
        if ( _isRunning && _timer != null ) { 
            
            _isRunning = false; 
            _timer.stop(); 
            System.println( "Timer Stopped. Elapsed: " + _elapsedTime ); 
            
            if ( _elapsedTime > 0 && _breathCount > 0 ) { 
                
                     _resultRate = _breathCount / ( _elapsedTime / 60.0f ); 
            
            } else { _resultRate = 0.0f; } /* TODO: Freestyle input */ 
            
            _showResults = true; 

            WatchUi.requestUpdate(); 
            
        } 
    }


    function resetTimer() as Void { 
        
        if ( _showResults ) { 
            
            _showResults = false; 
            _elapsedTime = 0; 
            _resultRate  = 0.0f; 
            
            System.println( "Timer Reset" ); 
            WatchUi.requestUpdate(); 
        } 
    }


    function timerCallback() as Void { 
        
        _elapsedTime++; 
        WatchUi.requestUpdate(); 
    }
    
    
    private function formatTime( totalSeconds as Lang.Number ) as Lang.String { 
        
        var minutes = totalSeconds / 60; 
        var seconds = totalSeconds % 60; 
        
        return Lang.format( "$1$:$2$", [ minutes.format( "%02d" ), seconds.format( "%02d" ) ] ); }

}
