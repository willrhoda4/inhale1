using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;

/**
 * Main Application class for the BreathCount Timer.
 */
class BreathCountApp extends Application.AppBase {

    /**
     * Constructor.
     */
    function initialize() {
        AppBase.initialize();
    }

    function onStart( state as Lang.Dictionary? ) as Void {
    }

    function onStop(  state as Lang.Dictionary? ) as Void {
    }

    function getInitialView() {

        // Create instance of our main menu
        var menu     =     makeMainMenu();
        // Create instance of our main menu delegate (which extends Menu2InputDelegate)
        var delegate = new MainMenuDelegate();

        // Return the menu object and its delegate pair.
        return [ menu, delegate ];
    }
}

/**
 * Helper function to easily get a reference to the main application object.
 * @return BreathCountApp The application object
 */
function getApp() as BreathCountApp {
    return Application.getApp() as BreathCountApp;
}