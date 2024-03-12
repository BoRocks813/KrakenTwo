#----------------------------------------------------------------------#
#                               KRAKENTWO                              #
#                                 2024                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


# This file contains functions pertaining to saving/editing files
# beyond the scope of the program

source("config.R")
source("vals.R")


# Creates a new CSV file for storing scouting data based on an input fileName
#
# This is only needed to form the basic file skeleton and is usually only run
# at first startup of a competition
createFile <- function(fileName) {
  # Creates a new easily accessible path to place the file based on the predetermined
  # path defined in config.R
  filePath <- paste0(path, fileName)
  
  # If there is not already a file by that name at that location, it will create 
  # a new empty CSV
  if(!(file.exists(filePath))) {
    write.csv(data.frame(), filePath, row.names = FALSE)
  }
}



# This function saves all of the current data as well as creating a backup folder
# for reference later
saveAllData <- function() {
  # Saving all of the various active dataframes
  write.csv(vals$mainframe, paste0(path, "mainframe.csv"), row.names = FALSE)
  write.csv(vals$scheduleframe, paste0(path, "schedule.csv"), row.names = FALSE)
  write.csv(vals$teamframe, paste0(path, "teamframe.csv"), row.names = FALSE)
  write.csv(vals$teammatchesframe, paste0(path, "teammatchesframe.csv"), row.names = FALSE)
  
  
  # Gathering the date and time to name the new folder for the data backup
  time <- as.POSIXlt(Sys.time())
  
  mon <- time$mon + 1
  d <- time$mday
  
  h <- time$hour
  m <- as.character(time$min)
  
  ftime <- paste0(mon, "-", d, "_", h, ".", m)
  
  # The path of our new folder
  newPath <- paste0(path, gsub(" ", "", competitionName), "scoutingdata_", ftime, "/")
  
  dir.create(newPath)
  
  # Saving the active dataframes in the new backup folder
  write.csv(vals$mainframe, paste0(newPath, "mainframe.csv"), row.names = FALSE)
  write.csv(vals$scheduleframe, paste0(newPath, "schedule.csv"), row.names = FALSE)
  write.csv(vals$teamframe, paste0(newPath, "teamframe.csv"), row.names = FALSE)
  write.csv(vals$teammatchesframe, paste0(newPath, "teammatchesframe.csv"), row.names = FALSE)
}


# DATAFRAME SAVE FUNCTIONS

saveMainframe <- function() {
  filePath <- paste0(path, "mainframe.csv")
  
  write.csv(vals$mainframe, filePath, row.names = FALSE)
}

saveTeamframe <- function() {
  filePath <- paste0(path, "teamframe.csv")
  
  write.csv(vals$teamframe, filePath, row.names = FALSE)
}

saveScheduleframe <- function() {
  filePath <- paste0(path, "scheduleframe.csv")
  
  write.csv(vals$scheduleframe, filePath, row.names = FALSE)
}

saveTeammatchesframe <- function() {
  filePath <- paste0(path, "teammatchesframe.csv")
    
  write.csv(vals$teammathesframe, filePath, row.names = FALSE)
}





