using Toybox.WatchUi;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Lang;


class FreestyleCountPickerDelegate extends WatchUi.PickerDelegate {

    private var _meditationView        as MeditationView; // Reference to our mode-aware view

    function initialize( meditationView as MeditationView ) {
        
        PickerDelegate.initialize();
        _meditationView = meditationView;        
    }   


    function onAccept( values as Lang.Array) as Lang.Boolean {

        var breathCount = values[0] as Lang.Number;

        System.println( "Freestyle Breaths entered: " + breathCount );

        _meditationView._breathCount = breathCount;

        _meditationView.saveSession();


        WatchUi.pushView( 
            new ResultsView( _meditationView ), 
            new ResultsDelegate( _meditationView._mode ), 
            WatchUi.SLIDE_LEFT 
        );



        return true;
    }

    function onCancel() as Lang.Boolean {

        WatchUi.popView( WatchUi.SLIDE_RIGHT ); // Go back to session menu. 
        
        return true;
    }
}