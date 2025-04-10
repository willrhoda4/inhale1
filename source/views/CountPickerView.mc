using Toybox.WatchUi;
using Toybox.Lang;





 

// --- DailyCountPickerView (Moved to top level) ---
class CountPickerView extends WatchUi.Picker {
   
   
    function initialize( title as Lang.String?, currentCount as Lang.Number? ) {
   

        if ( !(currentCount instanceof Lang.Number) ) { currentCount = 108; }


        var factory      = new NumberPickerNumberFactory( 0, 999, 1 );
        
        if ( currentCount < -1 || currentCount >= factory.getSize() ) {
            currentCount = 106; // Fallback for 108
        }

        Picker.initialize( {
            :title => new WatchUi.Text({
                :text  =>  title,
                :locX  =>  WatchUi.LAYOUT_HALIGN_CENTER,
                :locY  =>  WatchUi.LAYOUT_VALIGN_BOTTOM,
                :color =>  Graphics.COLOR_WHITE
            }),
            :pattern  => [ factory      ],
            :defaults => [ currentCount ]
        });
    }
}

