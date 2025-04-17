using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

/**
 * Input Delegate class for the Meditation Timer.
 * No major changes needed yet for mode handling, as View holds the state.
 */
class InhaleDelegate extends WatchUi.BehaviorDelegate {


    /**
     * Constructor.
     * @param view The MeditationView instance this delegate manages.
     */
    function initialize() {

        BehaviorDelegate.initialize();

    }

   function onSelect() as Lang.Boolean { return true; }
   
   
   function onBack() as Lang.Boolean { return true; }
}
