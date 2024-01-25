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
  
  # Startup
  observe({
    if(vals$startupDone == FALSE) {
      startup()
    }
  })
  
  
  # Data Page
<<<<<<< Updated upstream
  
  # Runs if the enter button is hit
  # Saves the data in the textbox into previewframe so
  # user can preview before submitting the data
  observeEvent(input$enterData, {
    f <- input$dataInput
    
    parsed <- parseData(f)
    
    vals$previewframe <- parsed
  })
  
=======
>>>>>>> Stashed changes
  observeEvent(input$yesData, {
    
  })
  
<<<<<<< Updated upstream
  observeEvent(input$noData, {
    
  })
  
=======
>>>>>>> Stashed changes
  
  # Teams Page
  observe({
    updateSelectInput(session, "pickTeam", 
                      choices = vals$teamframe$teamNum)
  })
  
  
}