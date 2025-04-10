using Toybox.WatchUi;
using Toybox.Lang;


/**
 * Factory class to provide numbers to the Picker.
 */
class NumberPickerNumberFactory extends WatchUi.PickerFactory {
    private var _start as Lang.Number;
    private var _stop as Lang.Number;
    private var _increment as Lang.Number;

    /**
     * Constructor for the NumberPickerNumberFactory.
     * @param start The starting number of the range.
     * @param stop The ending number of the range.
     * @param increment The step value between numbers.
     */
    function initialize(start as Lang.Number, stop as Lang.Number, increment as Lang.Number) {
        PickerFactory.initialize(); // Call the parent constructor
        _start = start;
        _stop = stop;
        _increment = increment;
    }

    /**
     * Gets the total number of items in the picker.
     * @return Lang.Number The total number of values.
     */
    function getSize() as Lang.Number {
        return ((_stop - _start) / _increment) + 1;
    }

    /**
     * Generates a Drawable (what to display) for an item at a given index.
     * @param item The index of the item.
     * @param isSelected True if the item is currently selected.
     * @return WatchUi.Drawable The Text object to display.
     */
    function getDrawable(item as Lang.Number, isSelected as Lang.Boolean) as WatchUi.Drawable or Null {
        var value = _start + (item * _increment);
        return new WatchUi.Text({
            :text => value.toString(),
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :color => Graphics.COLOR_WHITE
        });
    }

    /**
     * Returns the actual value associated with an item at a given index.
     * @param item The index of the item.
     * @return Lang.Object The numerical value.
     */
    function getValue(item as Lang.Number) as Lang.Object or Null {
        return _start + (item * _increment);
    }
}