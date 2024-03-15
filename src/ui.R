#----------------------------------------------------------------------#
#                               KRAKENTWO                              #
#                                 2024                                 #
#                                                                      #
#                 Created by Will Brittian of Team 6672                #
#----------------------------------------------------------------------#


#
# This file is where all of the UI elements are
# laid out. The layout of what the user will see
# is defined here
# 


# Imports
library(shiny)
library(shinyWidgets)
library(bslib)
library(DT)

source("vals.R")


theme <- bs_theme(
  version = 5,
  bg = "rgb(15, 13, 13)",
  fg = "rgb(254, 254, 254)",
  primary = "#EE7679"
)




# Defines the UI
# The navbarPage layout is what allows us to create
# our multi-page layout
# We then nest the fluidPage layout within the individual tabPanels because
# it is the more traditional CSS-like way of organizing things
ui <- navbarPage(
  
 # title = div(icon("gitkraken", lib = "font-awesome"), " KrakenTwo"),
  title = "KrakenTwo",
  
  
  tabPanel("Data",
           fluidRow(
             column(
               wellPanel(
                 textAreaInput("dataInput", "Input Scout Data", width = "330px", height = "200px", resize = "none"),
                 actionButton("enterData", "Enter"),
                 h4("Apply Data?"),
                 actionButton("yesData", "Yes", width = '60px'),
                 actionButton("noData", "No", width = '60px')
               ),
               wellPanel(
                 h5("WARNING: this button will delete all current data. Consider exporting the data first."),
                 actionButton("deleteFiles", "Delete Files")
               ),
               width = 3
             ),
             column(
               DTOutput("preview"),
               width = 9
             )
           )
  ),  
  
  tabPanel("Teams",
           fluidRow(
             column(
               3,
               wellPanel(
                 selectInput("pickTeam", 
                             "Select a Team:", 
                             ""),
                 actionButton("enterTeamSearch",
                              "Enter")
               ),
               wellPanel(
                 plotOutput("teamPhoto")
               ),
             ),
             column(
               9,
               DTOutput("teamDT"),
               # TODO add nuanced data views once format and metrics decided
             )
           )
  ),
  
  tabPanel("Matches",
           fluidRow(
             column(
               3,
               sidebarPanel(
                 textInput("matchsearch",
                           "Search:",
                           placeholder = "Enter match number"),
                 actionButton("entermatchsearch", "Enter"),
                 width = 12
               )
             ),
             column(
               9,
               DTOutput("matchsearchDT")
             )
           )   
  ),
  
  tabPanel("Competition",
           DTOutput("mainframeOutput")
  ),
  
  tabPanel("Graph",
           
  ),
  
  tabPanel("Match Planner",
           fluidRow(
             column(
               3,
               wellPanel(
                 selectInput(
                   "selectedMatch",
                   "Select a Match",
                   choices = ""
                 )
               ),
               wellPanel(
                 textOutput("winChanceourTeam"),
                 textOutput("predictedScore"),
                 textOutput("driverStation"),
                 textOutput("alliance")
               )
             ),
             column(
               9,
               DTOutput("plannertable")
               # TODO add more data once decided (based on teams page)
             )
           )
  ),
  
  tabPanel("Stats",
           # TODO (very low priority) fix colors to make more visible or switch
           # widgets
           materialSwitch(inputId = "showstats", label = "Show All Stats"),
           DTOutput("statsData")
  ),
  
  tabPanel("Schedule",
           DTOutput("matchScheduleDT")
  ),
  
  tabPanel("Functions",
           fluidRow(
             h4("Online Functions (internet required)"),
             actionButton("getSchedule", "Get Schedule"),
             actionButton("setupTeams", "Setup Teams List"),
             actionButton("getTeamMatches", "Get Team Matches"),
             actionButton("pullEPAs", "Update EPAs")
           ),
           fluidRow(
             h4("Data"),
             actionButton("recalcVals", "Recalculate Team Stats"),
             actionButton("recalcMatches", "Recalculate Match Stats")
           ),
           fluidRow(
             h4("File Editing"),
             actionButton("updatedata", "Update Data from Files"),
             actionButton("savedata", "Save Data")
           )
  ),
  
  
  id = "main",
  
  selected = "Data",
  
  theme = theme,
  
  tags$script(src="https://kit.fontawesome.com/7f698a1940.js")
)

