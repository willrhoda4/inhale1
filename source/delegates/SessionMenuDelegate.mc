using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityRecording;
using Toybox.FitContributor; // For creating custom fields
using Toybox.Activity;





class SessionMenuDelegate extends WatchUi.Menu2InputDelegate {


    private var _breathCountView as BreathCountView; // Reference to our mode-aware view
    
    
    function initialize(breathCountView as BreathCountView) {

        Menu2InputDelegate.initialize();

        _breathCountView = breathCountView; // Remove if not used
    }


    function onSelect( item as WatchUi.MenuItem ) as Void {


        var id = item.getId();

        if (id == :save_session) {


            if (_breathCountView._mode == :freestyle) {

                var defaultCount = Application.Storage.getValue( "dailyBreathCount" );
                var picker       = new CountPickerView( "set count", defaultCount );        


                WatchUi.pushView(
                    picker, 
                    new FreestyleCountPickerDelegate( _breathCountView ), 
                    WatchUi.SLIDE_LEFT
                );

                return;
            }            


            System.println("Save Session selected");
            
            _breathCountView.saveSession();


            WatchUi.pushView( 
                new ResultsView( _breathCountView ), 
                new ResultsDelegate( _breathCountView._mode ), 
                WatchUi.SLIDE_LEFT 
            );



        } else if (id == :return_session) {

            System.println("Return to Session selected");

            WatchUi.popView( WatchUi.SLIDE_RIGHT     );
            _breathCountView.resumeMeditation();


        } else if (id == :discard_session) {

            System.println("Discard Session selected");

            _breathCountView.discardSession();
            WatchUi.popView( WatchUi.SLIDE_RIGHT     );
            WatchUi.popView( WatchUi.SLIDE_IMMEDIATE );
        }
    }


    function onBack() as Void {
     
        System.println( "Back pressed on Results/Save menu - Resuming" );

        WatchUi.popView( WatchUi.SLIDE_RIGHT     );      
        _breathCountView.resumeMeditation();
    }
}