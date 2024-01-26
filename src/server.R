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
  
  # Runs if the enter button is hit
  # Saves the data in the textbox into previewframe so
  # user can preview before submitting the data
  observeEvent(input$enterData, {
    f <- input$dataInput
    
    parsed <- parseData(f)
    
    vals$previewframe <- parsed
  })
  
  observeEvent(input$yesData, {
    if(nrow(vals$previewframe) == 1) {
      if(nrow(vals$mainframe) > 0) {
        repeatFound <- FALSE
        
        for(row in 1:length(vals$mainframe$teamNum)) {
          if(vals$mainframe[row, 1] == vals$previewframe[1, 1] & vals$mainframe[row, 2] == vals$previewframe[1, 2]) {
            repeatFound <- TRUE
            showModal(repeatModal())
          }
        }
        
        if(repeatFound == FALSE) {
          vals$mainframe <- rbind(vals$mainframe, calcValues(vals$previewframe[1, ]))
          
          # TODO add findTeamIndex and matchesPlayed
          
          saveMainframe()
          saveTeamframe()
          resetDF(vals$previewframe)
          updateTextAreaInput(session, "dataInput", value = "")
        }
        
      } else {
        # TODO: maybe add calcValues here when format set
        vals$mainframe <- rbind(vals$mainframe, vals$previewframe[1, ])
        
        # TODO: add findTeamIndex and matchesPlayed (in teamframe)
        
        saveMainframe()
        saveTeamframe()
        resetDF(vals$previewframe)
        updateTextAreaInput(session, "dataInput", value = "")
      }
    }
  })
  

  observeEvent(input$noData, {
    
  })

  
  # Teams Page
  observe({
    updateSelectInput(session, "pickTeam", 
                      choices = vals$teamframe$teamNum)
  })
  
  
}