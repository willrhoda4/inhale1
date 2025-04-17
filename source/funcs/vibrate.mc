using Toybox.Lang;
using Toybox.Attention;
using Toybox.Application;


function vibrate ( duration as Lang.Number ) as Void {

        
        var setToVibe = Application.Storage.getValue( "vibrationSetting" );

        if ( !( setToVibe instanceof Lang.Boolean ) ) { setToVibe = true; }
        
        
        if ( Attention has :vibrate ) {

            var milliseconds = duration * 1000;

                                                            /*
                                                VibeProfile's accept:
                                                - dutyCycle: 0-100
                                                - duration:  in milliseconds
                                                            */
            var vibeData     = [ new Attention.VibeProfile( 50, milliseconds ) ];

            if ( setToVibe ) { Attention.vibrate( vibeData ); }
        } 
}