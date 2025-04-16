using Toybox.WatchUi;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Lang;


class FreestyleCountPickerDelegate extends WatchUi.PickerDelegate {

    private var _view        as BreathCountView; // Reference to our mode-aware view

    function initialize( view as BreathCountView ) {
        
        PickerDelegate.initialize();
        _view = view;        
    }


    function onAccept( values as Lang.Array) as Lang.Boolean {

        var breathCount = values[0] as Lang.Number;

        System.println( "Freestyle Breaths entered: " + breathCount );

        _view._breathCount = breathCount;

        _view.saveSession();

        WatchUi.popView( WatchUi.SLIDE_RIGHT     );
        WatchUi.popView( WatchUi.SLIDE_IMMEDIATE ); // Go back to picker view
        WatchUi.popView( WatchUi.SLIDE_IMMEDIATE ); // Go back to picker view


        return true;
    }

    function onCancel() as Lang.Boolean {

        WatchUi.popView( WatchUi.SLIDE_RIGHT ); // Go back to session menu. 
        
        return true;
    }
}