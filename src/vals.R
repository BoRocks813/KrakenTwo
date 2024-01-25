#----------------------------------------------------------------------#
#                              KRAKENZERO                              #
#                                 2023                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#



# This file contains all of the static and reactive values for the app

tbaBase <- "https://www.thebluealliance.com/api/v3"

authKey <- "?X-TBA-Auth-Key=4dFDCdOUUHc0cp22wPCRs6Wc7Xl7omiICPRpT3CMPKU0AsYRiNO4b7ZMetfO5Yv5"



# The container for the reactive values that will be frequently accessed by all
# parts of the app
#
# This is where we store most of our collected data while
# the app is running



vals <- reactiveValues(
  templateframe = data.frame(
    teamNum = c(),
    matchNum = c(),
    alliance = c(),
    driveStation = c(),
    
    startLocation = c(),
    preload = c(),
    
    mobility = c(),
    autoPickups = c(),
    autoAmp = c(),
    autoAmpMisses = c(),
    autoSpeakerClose = c(),
    autoSpeakerMid = c(),
    autoSpeakerCloseMisses = c(),
    autoSpeakerMidMisses = c(),
    
    friendlyPickups = c(),
    neutralPickups = c(),
    oppPickups = c(),
    sourcePickups = c(),
    
    teleopSpeakerClose = c(),
    teleopSpeakerMid = c(),
    teleopSpeakerFar = c(),
    teleopSpeakerCloseMisses = c(),
    teleopSpeakerMidMisses = c(),
    teloepSpeakerFarMisses = c(),
    
    teleopAmp = c(),
    teleopAmpMisses = c(),
    teleopTrap = c(),
    teleopTrapMisses = c(),
    
    climb = c(),
    climbTime = c(),
    climbPartners = c(),
    spotlight = c(),
    
    shuttle = c(),
    shooter = c(),
    intake = c(),
    speed = c(),
    driver = c(),
    
    scoutName = c(),
    comments = c()
  ),
  
  mainframe = data.frame(),
  
  teamframe = data.frame(),
  
  scheduleframe = data.frame(),
  
  teammatchesframe = data.frame(),
  
  
  previewframe = data.frame(),
  
  
  startupDone = FALSE
)
