using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityRecording;
using Toybox.FitContributor; // For creating custom fields
using Toybox.Activity;





class SessionMenuDelegate extends WatchUi.Menu2InputDelegate {


    private var _MeditationView as MeditationView; // Reference to our mode-aware view
    
    
    function initialize(MeditationView as MeditationView) {

        Menu2InputDelegate.initialize();

        _MeditationView = MeditationView; // Remove if not used
    }


    function onSelect( item as WatchUi.MenuItem ) as Void {


        var id = item.getId();

        if (id == :save_session) {


            if (_MeditationView._mode == :freestyle) {

                var defaultCount = Application.Storage.getValue( "dailyMeditation" );
                var picker       = new CountPickerView( "set count", defaultCount );        


                WatchUi.pushView(
                    picker, 
                    new FreestyleCountPickerDelegate( _MeditationView ), 
                    WatchUi.SLIDE_LEFT
                );

                return;
            }            


            System.println("Save Session selected");
            
            _MeditationView.saveSession();


            WatchUi.pushView( 
                new ResultsView( _MeditationView ), 
                new ResultsDelegate( _MeditationView._mode ), 
                WatchUi.SLIDE_LEFT 
            );



        } else if (id == :return_session) {

            System.println("Return to Session selected");

            WatchUi.popView( WatchUi.SLIDE_RIGHT     );
            _MeditationView.resumeMeditation();


        } else if (id == :discard_session) {

            System.println("Discard Session selected");

            _MeditationView.discardSession();
            WatchUi.popView( WatchUi.SLIDE_RIGHT     );
            WatchUi.popView( WatchUi.SLIDE_IMMEDIATE );
        }
    }


    function onBack() as Void {
     
        System.println( "Back pressed on Results/Save menu - Resuming" );

        WatchUi.popView( WatchUi.SLIDE_RIGHT     );      
        _MeditationView.resumeMeditation();
    }
}