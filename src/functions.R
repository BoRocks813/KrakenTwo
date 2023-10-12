#----------------------------------------------------------------------#
#                              KRAKENZERO                              #
#                                 2023                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


# This file contains miscellaneous functions used in KrakenZero

source("config.R")

# This function dictates any housekeeping actions needed when starting up the app
startup <- function() {
  # Sets the current working directory (where the app will access files)
  setwd(path)
  
  # Tells the server to not rerun this function
  vals$startupDone <- TRUE
}