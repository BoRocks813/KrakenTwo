#----------------------------------------------------------------------#
#                               KRAKENTWO                              #
#                                 2024                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


#
# The server function is where the majority of the
# functions necessary to run KrakenTwo are called
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
    if(input$dataInput != "") {
      f <- input$dataInput
      
      parsed <- parseData(f)
      
      vals$previewframe <- parsed
    }
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
          
          recalcTeamValues(vals$previewframe$teamNum[1])
          saveMainframe()
          saveTeamframe()
          vals$previewframe <- vals$templateframe
          updateTextAreaInput(session, "dataInput", value = "")
        }
        
      } else {
        # TODO: maybe add calcValues here when format set
        vals$mainframe <- rbind(vals$mainframe, calcValues(vals$previewframe[1, ]))
        
        recalcTeamValues(vals$previewframe$teamNum[1])
        saveMainframe()
        saveTeamframe()
        vals$previewframe <- vals$templateframe
        updateTextAreaInput(session, "dataInput", value = "")
      }
    }
  })
  

  observeEvent(input$noData, {
    
  })
  
  
  observeEvent(input$deleteFiles, {
    showModal(deleteModal())
  })
  
  observeEvent(input$confirmDelete, {
    vals$mainframe <- vals$templateframe
    vals$teamframe <- vals$teamframeTemplate
    if(file.exists(paste0(path, "mainframe.csv"))) {
      file.remove(paste0(path, "mainframe.csv"))
    }
    removeModal()
  })
  
  
  
  output$preview <- renderDT(datatable(vals$previewframe, options = list(scrollX = TRUE, paging = FALSE),
                                       selection = "single"))
  
  

  
  # Teams Page
  observe({
    updateSelectInput(session, "pickTeam", 
                      choices = vals$teamframe$teamNum)
  })
  
  observeEvent(input$enterTeamSearch, {
    tNum <- input$pickTeam
    
    vals$teamSearch <- vals$templateframe
    
    
    picPath <- paste0(path, "Pictures\\", tNum, ".png")
    picAlt <- paste0(path, "Pictures\\", tNum, ".JPG")
    nopePath <- paste0(path, "Pictures\\nope.png")
    
    if(file.exists(picPath)) {
      output$teamPhoto <- renderImage(list(src = picPath, width = 280), deleteFile = FALSE)
    } else if(file.exists(picAlt)) {
      output$teamPhoto <- renderImage(list(src = picAlt, width = 280), deleteFile = FALSE)
    } else {
      output$teamPhoto <- renderImage(list(src = nopePath, width = 280), deleteFile = FALSE)
    }
    
    
    
    idx <- which(tNum == vals$mainframe$teamNum)
    
    
    
    
    
    if(length(idx) > 0) {
      for(t in idx) {
        vals$teamSearch <- rbind(vals$teamSearch, vals$mainframe[t, ])
      }
    }
    
    output$teamDT <- renderDT(datatable(vals$teamSearch, options = list(scrollX = TRUE, scrollY = "480px", paging = FALSE),
                                        selection = "single"))
  })
  
  
  # Matches Page
  
  
  
  # Competition Page
  
  output$mainframeOutput <- renderDT(datatable(vals$mainframe[order(vals$mainframe$matchNum), ],
                                               options = list(scrollX = TRUE, scrollY = "540px",
                                                              paging = FALSE)))
  
  
  # Graphs Page
  
  
  
  # Match Planner Page
  
  
  
  
  # Stats Page
  
  output$statsData <- renderDT(datatable(vals$teamframe, 
                                         options = list(scrollX = TRUE, scrollY = "540px", paging = FALSE)))
  
  
  # Schedule Page
  # TODO resolve error here
  observe({
    output$matchScheduleDT <- renderDT({
      datatable(
        vals$scheduleframe,
        extensions = "FixedColumns",
        options = list(scrollX = TRUE, scrollY = "540px", paging = FALSE),
        selection = "single"
      ) %>% formatStyle(
        9, 10,
        color = styleEqual(c("r", "b", "even"), c("red", "blue", "gray"))
      )
    })
  })
  
  
  
  # Functions Page
  
  observeEvent(input$getSchedule, {
    vals$scheduleframe <- getSchedule()
  })
  
  observeEvent(input$setupTeams, {
    vals$teamframe <- getTeams()
  })
  
  observeEvent(input$getTeamMatches, {
    getTeamMatches()
  })
  
  observeEvent(input$pullEPAs, {
    getTeamEPAs()
  })
  
  
  observeEvent(input$recalcVals, {
    recalcAllValues()
  })
  
  observeEvent(input$recalcMatches, {
    recalcAllMatches()
  })
  
  
  observeEvent(input$updatedata, {
    if(file.exists(paste0(path, "mainframe.csv"))) {
      vals$mainframe <- read.csv(paste0(path, "mainframe.csv"))
    } else {
      vals$mainframe <- vals$templateframe
    }
    
    if(file.exists(paste0(path, "teamframe.csv"))) {
      vals$teamframe <- read.csv(paste0(path, "teamframe.csv"))
    }
    
    if(file.exists(paste0(path, "schedule.csv"))) {
      vals$scheduleframe <- read.csv(paste0(path, "schedule.csv"))
    }
    
    if(file.exists(paste0(path, "teammatches.csv"))) {
      vals$teammatchesframe <- read.csv(paste0(path, "teammatches.csv"))
    }
  })
  
  observeEvent(input$savedata, {
    saveAllData()
  })
  
  
  
}