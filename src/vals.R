#----------------------------------------------------------------------#
#                              KRAKENZERO                              #
#                                 2023                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#



# This file contains all of the static and reactive values for the app


# The container for the reactive values that will be frequently accessed by all
# parts of the app
#
# This is where we store most of our collected data while
# the app is running
vals <- reactiveValues(
  mainframe = data.frame(),
  
  teamframe = data.frame(),
  
  scheduleframe = data.frame(),
  
  teammatchesframe = data.frame(),
  
  startupDone = FALSE
)