using Toybox.ActivityRecording;
using Toybox.FitContributor;
using Toybox.Activity;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application; // For Rez access

/**
 * Creates and starts an ActivityRecording session for meditation.
 * Returns the session and created developer field objects.
 * @return Dictionary containing {:session, :fieldMeditation, :fieldBreathRate} or null on error
 */
function initiateSession() as Lang.Dictionary or Null {


    var session             = null;
    var devFieldMeditation = null;
    var devFieldBreathRate  = null;


    try {
       
        System.println("Creating session...");
      
        session = ActivityRecording.createSession( {
            :name     => "inhale1", // Use app name from strings
            :sport    => Activity.SPORT_MEDITATION,
            :subSport => Activity.SUB_SPORT_BREATHING // Use specific enums
        } );

        // Create and STORE the developer fields
        devFieldMeditation =   session.createField(
                                    "total_breaths", 
                                     0, 
                                     FitContributor.DATA_TYPE_UINT16,
                                    { 
                                        :mesgType=>FitContributor.MESG_TYPE_SESSION,
                                        :units=>"breaths"
                                    }
                                ); // Use Rez string

        devFieldBreathRate =    session.createField(
                                    "avg_breath_rate", 
                                    1, 
                                    FitContributor.DATA_TYPE_FLOAT,
                                    { 
                                        :mesgType=>FitContributor.MESG_TYPE_SESSION, 
                                        :units=>"bpm"
                                    }
                                ); // Use Rez string


        session.start();

        System.println("Session Started and Recording");


        // Return all created objects in a dictionary
        return {
            :session          => session,
            :fieldMeditation => devFieldMeditation,
            :fieldBreathRate  => devFieldBreathRate
        };

    } catch ( ex instanceof Lang.Exception ) {

        System.println( "Error starting session: " + ex.getErrorMessage() );
        // Clean up if session was partially created but failed

        return null; // Indicate failure
    }
}
