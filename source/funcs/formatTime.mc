using Toybox.Lang;





function formatTime( time as Lang.Number ) as Lang.String { 


    // Convert time to seconds
    var totalSeconds = time / 1000;
    
    var minutes = totalSeconds / 60; 
    var seconds = totalSeconds % 60; 
    
    return Lang.format( 
        "$1$:$2$", 
        [ 
            minutes.format( "%02d" ), 
            seconds.format( "%02d" ) 
        ] 
    ); 
}

