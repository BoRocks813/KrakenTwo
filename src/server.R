#----------------------------------------------------------------------#
#                              KRAKENZERO                              #
#                                 2023                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


#
# The server function is where the majority of the
# functions necessary to run KrakenZero are called
# 


# Imports
library(shiny)

source("ui.R")
source("vals.R")
source("files.R")
source("config.R")
source("functions.R")


# Physically creating the server function
server <- function(input, output, session) {
  observe({
    if(vals$startupDone == FALSE) {
      startup()
    }
  })
  
  observeEvent(input$yesData, {
    
  })
}