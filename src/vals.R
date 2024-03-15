#----------------------------------------------------------------------#
#                               KRAKENTWO                              #
#                                 2024                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#



# This file contains all of the static and reactive values for the app

tbaBase <- "https://www.thebluealliance.com/api/v3"

statboticsBase <- "https://api.statbotics.io/v3"

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
    comments = c(),
    
    scoredT = c(),
    scoredA = c(),
    scored = c(),
    pointsE = c(),
    missed = c(),
    accuracy = c(),
    speak = c(),
    speakA = c(),
    speakT = c()
  ),
  
  teamframeTemplate = data.frame(
    teamNum = c(),
    EPA = c(),
    aS = c(),
    aSa = c(),
    aSt = c(),
    accuracy = c(),
    aPPE = c(),
    speak = c(),
    speakA = c(),
    speakT = c(),
    aT = c(),
    CT = c()
  ),
  
  scheduleframeTemplate = data.frame(
    round = c(),
    match_number = c(),
    red1 = c(),
    red2 = c(),
    red3 = c(),
    blue1 = c(),
    blue2 = c(),
    blue3 = c()
  ),
  
  mainframe = data.frame(),
  
  teamframe = data.frame(),
  
  scheduleframe = data.frame(),
  
  teammatchesframe = data.frame(),
  
  previewframe = data.frame(),
  
  
  startupDone = FALSE
)
