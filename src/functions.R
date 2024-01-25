#----------------------------------------------------------------------#
#                              KRAKENZERO                              #
#                                 2023                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


# This file contains miscellaneous functions used in KrakenZero

# In general, functions are arranged in alphabetical order

source("config.R")
source("vals.R")

# This is an incredibly important function that
# sets the template for storing any dataframe in the program
emptyDF <- function() {
  return(vals$templateframe)
}


getSchedule <- function() {
  
  url <- paste0(tbaBase, "/event/", eventCode, "/matches", authKey)
  
  matches <- content(GET(url))
  
  schedule <- data.frame(round = c(),
                         match_number = c(),
                         red1 = c(),
                         red2 = c(),
                         red3 = c(),
                         blue1 = c(),
                         blue2 = c(),
                         blue3 = c()
  )
  
  for(m in 1:length(matches)) {
    if(matches[[m]]$comp_level == "qm") {
      curmatch <- matches[[m]]
      
      df <- data.frame(round = c(),
                       match_number = c(),
                       red1 = c(),
                       red2 = c(),
                       red3 = c(),
                       blue1 = c(),
                       blue2 = c(),
                       blue3 = c()
      )
      
      r1 <- curmatch$alliances$red$team_keys[[1]]
      r2 <- curmatch$alliances$red$team_keys[[2]]
      r3 <- curmatch$alliances$red$team_keys[[3]]
      
      b1 <- curmatch$alliances$blue$team_keys[[1]]
      b2 <- curmatch$alliances$blue$team_keys[[2]]
      b3 <- curmatch$alliances$blue$team_keys[[3]]
      
      r1 <- as.integer(substr(r1, 4, 7))
      r2 <- as.integer(substr(r2, 4, 7))
      r3 <- as.integer(substr(r3, 4, 7))
      
      b1 <- as.integer(substr(b1, 4, 7))
      b2 <- as.integer(substr(b2, 4, 7))
      b3 <- as.integer(substr(b3, 4, 7))
      
      mNum <- as.integer(curmatch$match_number)
      
      df <- data.frame(round = c("qf"),
                       match_number = c(mNum),
                       red1 = c(r1),
                       red2 = c(r2),
                       red3 = c(r3),
                       blue1 = c(b1),
                       blue2 = c(b2),
                       blue3 = c(b3)
      )
      
      schedule <- rbind(schedule, df)
    }
  }
  
  schedule2 <- schedule[order(schedule$match_number), ]
  return(schedule2)
}


# Parses the scouting data into a format readable by Kraken
parseData <- function(data) {
  info <- unlist(strsplit(unlist(strsplit(data, split = "|", fixed = TRUE)), "="))
  
  firstone <- info[1]
  
  if(firstone != "teamNum") {
    return(NULL)
  }
  
  names <- info[seq(1, length(info), 2)]
  values <- info[seq(2, length(info), 2)]
  
  names(values) <- names
  
  pData <- data.frame(as.list(values))
  
  parsedData <- data.frame(
    teamNum = c(as.integer(pData$teamNum[1])),
    matchNum = c(as.integer(pData$matchNum[1])),
    alliance = c(tolower(pData$alliance[1])),
    driveStation = c(pData$driveStation[1]),
    startLocation = c(as.integer(pData$startLocation[1])),
    preload = c(as.logical(pData$preload[1])),
    mobility = c(as.logical(pData$mobility[1])),
    autoPickups = c(pData$autoPickups[1]),
    autoAmp = c(as.integer(pData$autoAmp[1])),
    autoAmpMisses = c(as.integer(pData$autoAmpMisses[1])),
    autoSpeakerClose = c(as.integer(pData$autoSpeakerClose[1])),
    autoSpeakerMid = c(as.integer(pData$autoSpeakerMid[1])),
    autoSpeakerCloseMisses = c(as.integer(pData$autoSpeakerCloseMisses[1])),
    autoSpeakerMidMisses = c(as.integer(pData$autoSpeakerMidMisses[1])),
    friendlyPickups = c(as.integer(pData$friendlyPickups[1])),
    neutralPickups = c(as.integer(pData$neutralPickups[1])),
    oppPickups = c(as.integer(pData$oppPickups[1])),
    sourcePickups = c(as.integer(pData$sourcePickups[1])),
    teleopSpeakerClose = c(as.integer(pData$teleopSpeakerClose[1])),
    teleopSpeakerMid = c(as.integer(pData$teleopSpeakerMid[1])),
    teleopSpeakerFar = c(as.integer(pData$teleopSpeakerFar[1])),
    teleopSpeakerCloseMisses = c(as.integer(pData$teleopSpeakerCloseMisses[1])),
    teleopSpeakerMidMisses = c(as.integer(pData$teleopSpeakerMidMisses[1])),
    teleopSpeakerFarMisses = c(as.integer(pData$teleopSpeakerFarMisses[1])),
    teleopAmp = c(as.integer(pData$teleopAmp[1])),
    teleopAmpMisses = c(as.integer(pData$teleopAmpMisses[1])),
    teleopTrap = c(as.integer(pData$teleopTrap[1])),
    teleopTrapMisses = c(as.integer(pData$teleopTrapMisses[1])),
    climb = c(as.integer(pData$climb[1])),
    climbTime = c(as.integer(pData$climbTime[1])),
    climbPartners = c(as.integer(pData$climbPartners[1])),
    spotlight = c(as.integer(pData$spotlight[1])),
    shuttle = c(as.integer(pData$shuttle[1])),
    shooter = c(as.integer(pData$shooter[1])),
    intake = c(as.integer(pData$intake[1])),
    speed = c(as.integer(pData$speed[1])),
    driver = c(as.integer(pData$driver[1])),
    scoutName = c(as.integer(pData$scoutName[1])),
    comments = c(as.integer(pData$comments[1]))
    
  )
}


resetDFs <- function() {
  vals$mainframe <- vals$templateframe
  vals$teamframe <- vals$templateframe
  vals$scheduleframe <- vals$templateframe
  vals$teammatchesframe <- vals$templateframe
}


# This function dictates any housekeeping actions needed when starting up the app
startup <- function() {
  # Sets the current working directory (where the app will access files)
  setwd(path)
  
  
  
  
  
  # Tells the server to not rerun this function
  vals$startupDone <- TRUE
}

updateTeamSelect <- function() {
  
}



