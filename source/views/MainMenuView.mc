using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;

/**
 * View class for the main application menu.
 * CORRECTED: Extends View, uses Menu2 object.
 */
// --- CORRECTED: Extends View ---
class MainMenuView extends WatchUi.View {

    private var _menu as WatchUi.Menu2; // Holds the actual menu object

    /**
     * Constructor. Initializes the menu.
     */
    function initialize() {

        View.initialize();
        
        _menu = makeMainMenu(); 

    }

   
     function getMenu() as WatchUi.Menu2 {
        return _menu;
     }
}
