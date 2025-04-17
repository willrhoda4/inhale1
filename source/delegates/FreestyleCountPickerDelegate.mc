using Toybox.WatchUi;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Lang;


class FreestyleCountPickerDelegate extends WatchUi.PickerDelegate {

    private var _breathCountView        as BreathCountView; // Reference to our mode-aware view

    function initialize( breathCountView as BreathCountView ) {
        
        PickerDelegate.initialize();
        _breathCountView = breathCountView;        
    }   


    function onAccept( values as Lang.Array) as Lang.Boolean {

        var breathCount = values[0] as Lang.Number;

        System.println( "Freestyle Breaths entered: " + breathCount );

        _breathCountView._breathCount = breathCount;

        _breathCountView.saveSession();


        WatchUi.pushView( 
            new ResultsView( _breathCountView ), 
            new ResultsDelegate( _breathCountView._mode ), 
            WatchUi.SLIDE_LEFT 
        );



        return true;
    }

    function onCancel() as Lang.Boolean {

        WatchUi.popView( WatchUi.SLIDE_RIGHT ); // Go back to session menu. 
        
        return true;
    }
}