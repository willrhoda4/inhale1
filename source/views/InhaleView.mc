using Toybox.Attention;
using Toybox.WatchUi;
using Toybox.Graphics;




class InhaleView extends WatchUi.View {


    hidden var _timer;
    protected var text as WatchUi.Text or Null;

    function initialize() {

        View.initialize();

        _timer = null;
    }


    function onShow() {


        vibrate( 2 );

        text = new WatchUi.Text( {
                    :text=>"inhale...",
                    :color=>Graphics.COLOR_WHITE,
                    :font=>Graphics.FONT_LARGE,
                    :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                    :locY=>WatchUi.LAYOUT_VALIGN_CENTER
                } );


        _timer = new Timer.Timer();


        _timer.start( method( :backToSession ), 2000, true );
    }


    function onUpdate( dc as Graphics.Dc ) as Void {

        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_BLACK );
        dc.clear();
        text.draw( dc );
    }


    function backToSession() as Void {

        if ( _timer != null ) {

            _timer.stop();
            _timer = null;
        }

        WatchUi.popView( WatchUi.SLIDE_BLINK );
    }
}
