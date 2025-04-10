using Toybox.WatchUi;
using Toybox.Lang;


// --- DailyCountPickerDelegate (Moved to top level) ---
class DailyCountPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onAccept( values as Lang.Array ) as Lang.Boolean {
        
        var newDailyCount = values[0] as Lang.Number;
        
        System.println( "New Daily Count set: " + newDailyCount );
        
        Application.Storage.setValue( "dailyBreathCount", newDailyCount );
        
        var view     = new OptionsMenuView(); // Now OptionsMenuView IS the Menu2
        var delegate = new OptionsMenuDelegate();
        
        // pop tte picker and the previous menu
        // then refresh the menu with our new value.
        WatchUi.popView(                  WatchUi.SLIDE_RIGHT     ); 
        WatchUi.popView(                  WatchUi.SLIDE_IMMEDIATE );
        WatchUi.pushView( view, delegate, WatchUi.SLIDE_LEFT      );

        
        return true;
    }

    function onCancel() as Lang.Boolean {

        WatchUi.popView(WatchUi.SLIDE_RIGHT); // Pop the picker

        return true;
    }
}