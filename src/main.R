#----------------------------------------------------------------------#
#                              KRAKENZERO                              #
#                                 2023                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


# 
# This file is the center of KrakenZero
# This is where all of the functions are called to start the app
# 
# To run, press the "Run App" button at the top
#

# Imports
library(shiny)

# Links the files of the app together
source("ui.R")
source("server.R")
source("vals.R")


# Runs the application 
shinyApp(ui = ui, server = server)