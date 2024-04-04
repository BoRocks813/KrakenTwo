#----------------------------------------------------------------------#
#                               KRAKENTWO                              #
#                                 2024                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


# This file contains miscellaneous functions used in KrakenTwo

# In general, functions are arranged in alphabetical order

library(httr)
library(curl)

source("config.R")
source("vals.R")






calcValues <- function(df) {
  info <- data.frame(
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
    
  )
  
  info <- rbind(info, df)
  
  info$scoredT <- numeric(1)
  info$scoredA <- numeric(1)
  info$scored <- numeric(1)
  info$pointsE <- numeric(1)
  info$missed <- numeric(1)
  info$accuracy <- numeric(1)
  info$speak <- numeric(1)
  info$speakA <- numeric(1)
  info$speakT <- numeric(1)
  
  
  speaker <- info$teleopSpeakerClose[1] + info$teleopSpeakerMid[1] + info$teleopSpeakerFar[1] +
    info$autoSpeakerClose[1] + info$autoSpeakerMid[1]
  
  
  
  tscored <- info$teleopSpeakerClose[1] + info$teleopSpeakerMid[1] + info$teleopSpeakerFar[1] +
    info$teleopAmp[1] + info$teleopTrap[1]
  
  ascored <- info$autoSpeakerClose[1] + info$autoSpeakerMid[1] + info$autoAmp[1]
  
  epoints <- 0
  
  if(info$climb[1]) {
    if(info$spotlight[1] > 0) {
      epoints <- 4
    } else {
      epoints <- 3
    }
  } else {
    epoints <- 1
  }
  
  scored <- tscored + ascored + info$teleopTrap[1]
  
 
  misses <- info$autoAmpMisses[1] + info$autoSpeakerCloseMisses[1] + info$autoSpeakerMidMisses[1] +
    info$teleopSpeakerCloseMisses[1] +info$teleopSpeakerFarMisses[1] +info$teleopSpeakerFarMisses[1] + 
    info$teleopAmpMisses[1] + info$teleopTrapMisses[1]
  
  

  accuracy <- round((scored / (scored + misses)) * 100, digits = 2)
  
  if(scored - info$teleopTrap[1] > 0) {
    speak <- round(((speaker / (scored - info$teleopTrap[1])) * 100), digits = 2)
  } else {
    speak <- 100
  }
  
  if(ascored > 0) {
    speakA <- round(((info$autoSpeakerClose[1] + info$autoSpeakerMid[1]) / ascored) * 100, digits = 2)
  } else {
    speakA <- 100
  }
  
  if(tscored > 0) {
    speakT <- round(((info$teleopSpeakerClose[1] + info$teleopSpeakerMid[1] + info$teleopSpeakerFar[1]) /
                       tscored) * 100, digits = 2)
  } else {
    speakT <- 100
  }
  
  info$scoredT[1] <- tscored
  info$scoredA[1] <- ascored
  info$scored[1] <- scored
  info$pointsE[1] <- epoints
  info$missed[1] <- misses
  info$accuracy[1] <- accuracy
  info$speak <- speak
  info$speakA <- speakA
  info$speakT <- speakT
  
  
  return(info)
  
}


deleteModal <- function() {
  modalDialog(
    tagList(actionButton("confirmDelete", "Yes"),
            title = "Are you sure you want to delete all data?"
    )
  )
}


# This is an incredibly important function that
# sets the template for storing any dataframe in the program
emptyDF <- function() {
  return(vals$templateframe)
}

findTeamIndex <- function(num) {
  return(as.integer(which(vals$teamframe$teamNum == num)))
}



getEPA <- function(teamNum) {
  url <- paste0(statboticsBase, "/team_year/", teamNum, "/2024")
  
  data <- content(GET(url))
  
  EPA <- data$epa$breakdown$total_points$mean[1]
  
  return(EPA)
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
  
  
  withProgress(message = "Getting Schedule", {
    
    n <- length(matches)
    
    for(m in 1:n) {
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
        length(matches)   
        schedule <- rbind(schedule, df)
      }
    }
    
  for(m in 1:length(matches)) {
    if(matches[[m]]$comp_level == "qm") {
      curmatch <- matches[[m]]
      
      incProgress(1/n, detail = paste("Match", m))
      
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
  })
  
  schedule2 <- schedule[order(schedule$match_number), ]
  return(schedule2)
}


getTeamEPAs <- function() {
  for(t in 1:length(vals$teamframe)) {
    tNum <- vals$teamframe$teamNum[t]
    
    vals$teamframe$EPA[t] <- getEPA(tNum)
  }
}



getTeams <- function() {
  
  teamsURL <- paste0(tbaBase, "/event/", eventCode, "/teams", authKey)
  
  teams <- content(GET(teamsURL))
  
  statlist <- vals$teamframeTemplate
  
  withProgress(message = "Getting Teams List", {
    
    n <- length(teams)
    
    for(t in 1:n) {
      
      tNum <- as.integer(teams[[t]]$team_number[1])
      
      team <- data.frame(
        teamNum = c(tNum),
        EPA = c(getEPA(tNum)),
        aS = c(0),
        aSa = c(0),
        aSt = c(0),
        aPPE = c(0),
        speak = c(0),
        speakA = c(0),
        speakT = c(0),
        aT = c(0),
        CT = c(0)
      )
      
      statlist <- rbind(statlist, team)
      
      incProgress(1/n, detail = paste("Team", tNum))
      
    }
  })

  return(statlist)
  
}


# Team Matches
getTeamMatches <- function() {
  vals$teammatchesframe <- data.frame(teamNum = c(),
                                      matches = c(),
                                      alliances = c())
  
  
  for(team in 1:nrow(vals$teamframe)) {
    
    teamNum <- vals$teamframe$teamNum[team]
    
    matches <- c()
    alliances <- c()
    
    for(match in 1:nrow(vals$scheduleframe)) {
      
      if(vals$scheduleframe$red1[match] == teamNum ||
         vals$scheduleframe$red2[match] == teamNum ||
         vals$scheduleframe$red3[match] == teamNum) {
        
        matches <- append(matches, as.character(match))
        alliances <- append(alliances, "r")
        
      } else if(vals$scheduleframe$blue1[match] == teamNum ||
                vals$scheduleframe$blue2[match] == teamNum ||
                vals$scheduleframe$blue3[match] == teamNum) {
        
        matches <- append(matches, as.character(match))
        alliances <- append(alliances, "b")
        
      }
      
    }
    
    matchString <- paste(matches, collapse = ",")
    allianceString <- paste(alliances, collapse = ",")
    
    vals$teammatchesframe <- rbind(vals$teammatchesframe, data.frame(teamNum = c(teamNum), 
                                                                     matches = c(matchString),
                                                                     alliances = c(allianceString)))
  }
}


internetModal <- function(dataframe) {
  modalDialog(
    tagList(
      h4(paste0("No internet connection detected. Please connect to internet to retreive ", dataframe)),
    ),
    title = "No internet connection"
  )
}


# Loads data for program startup
loadData <- function() {
  
  if(file.exists(paste0(path, "mainframe.csv"))) {
    vals$mainframe <- read.csv(paste0(path, "mainframe.csv"))
  }
  
  if(file.exists(paste0(path, "scheduleframe.csv"))) {
    vals$scheduleframe <- read.csv(paste0(path, "scheduleframe.csv"))
  } else {
    if(has_internet()) {
      try({
        vals$scheduleframe <- getSchedule()
        saveScheduleframe()
      })
    } else {
      showModal(internetModal("schedule"))
    }
  }
  
  if(file.exists(paste0(path, "teamframe.csv"))) {
    vals$teamframe <- read.csv(paste0(path, "teamframe.csv"))
  } else {
    if(has_internet()) {
      vals$teamframe <- getTeams()
      saveTeamframe()
    } else {
      showModal(internetModal("teamframe"))
    }
  }
  
  if(file.exists(paste0(path, "teammatches.csv"))) {
    vals$teammatchesframe <- read.csv(paste0(path, "teammatches.csv"))
  } else {
  #  getTeamMatches()
  }
  
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
    autoPickups = c(pData$autonPickups[1]),
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
    climb = c(as.logical(pData$climb[1])),
    climbTime = c(as.integer(pData$climbTime[1])),
    climbPartners = c(as.integer(pData$climbPartners[1])),
    spotlight = c(as.logical(pData$spotlight[1])),
    shuttle = c(as.logical(pData$shuttle[1])),
    shooter = c(as.integer(pData$shooter[1])),
    intake = c(as.integer(pData$intake[1])),
    speed = c(as.integer(pData$speed[1])),
    driver = c(as.integer(pData$driver[1])),
    scoutName = c(pData$scoutName[1]),
    comments = c(pData$comments[1])
  )
  
  # TODO!!!!!! 
  # adjust to real format when Rishabh done
  
  return(parsedData)
}


recalcTeamValues <- function(tNum) {
  
  idx <- findTeamIndex(tNum)
  
  matches <- data.frame()
  
  matchIndexes <- which(vals$mainframe$teamNum == tNum) 
  
    
  if(length(matchIndexes) > 0) {
    for(match in matchIndexes) {
      matches <- rbind(matches, vals$mainframe[match, ])
    }
    
    
    # aS
    vals$teamframe$aS[idx] <- round(mean(matches$scored), digits = 2)
    
    # aSt
    vals$teamframe$aSt[idx] <- round(mean(matches$scoredT), digits = 2)
    
    # aSa
    vals$teamframe$aSa[idx] <- round(mean(matches$scoredA), digits = 2)
    
    # aPPE
    vals$teamframe$aPPE[idx] <- round(mean(matches$pointsE), digits = 2)
    
    # speak
    vals$teamframe$speak[idx] <- round(mean(matches$speak), digits = 2)
    
    # speakA
    vals$teamframe$speakA[idx] <- round(mean(matches$speakA), digits = 2)
    
    # speakT
    vals$teamframe$speakT[idx] <- round(mean(matches$speakT), digits = 2)
    
    # aT
    vals$teamframe$aT[idx] <- round(mean(matches$teleopTrap), digits = 2)
    
    # CT
    vals$teamframe$CT[idx] <- round(mean(matches$climbTime), digits = 2)
  } else {
    vals$teamframe$aS[idx] <- 0
    vals$teamframe$aSt[idx] <- 0
    vals$teamframe$aSa[idx] <- 0
    vals$teamframe$aPPE[idx] <- 0
    vals$teamframe$speak[idx] <- 0
    vals$teamframe$speakA[idx] <- 0
    vals$teamframe$speakT[idx] <- 0
    vals$teamframe$aT[idx] <- 0
    vals$teamframe$CT[idx] <- 0
  }
  
}


recalcAllMatches <- function() {
  for(t in 1:length(vals$mainframe)) {
    data <- vals$mainframe[t, 1:39]
    
    vals$mainframe[t, ] <- calcValues(data)
  }
}


recalcAllValues <- function() {
  for(t in 1:nrow(vals$teamframe)) {
    num <- vals$teamframe$teamNum[t]
    
    recalcTeamValues(num)
  }
}



repeatModal <- function() {
  modalDialog(
    tagList(
      h4("This looks like repeat data. Are you sure you want to add another entry to the system?"),
      actionButton("confirmApplyRepeat", "Yes")
    ),
    title = "Repeat Data?"
  )
}


resetDF <- function(dataframe) {
  dataframe <- vals$templateframe
}


resetDFs <- function() {
  vals$mainframe <- vals$templateframe
  vals$teamframe <- vals$teamframeTemplate
  vals$scheduleframe <- vals$scheduleframeTemplate
  vals$teammatchesframe <- vals$templateframe
}


# This function dictates any housekeeping actions needed when starting up the app
startup <- function() {
  # Sets the current working directory (where the app will access files)
  setwd(path)
  
  
  # Loads files on program startup
  loadData()
  
  # Tells the server to not rerun this function
  vals$startupDone <- TRUE
  
}

updateTeamSelect <- function() {
  
  
}
