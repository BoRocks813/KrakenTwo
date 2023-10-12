#----------------------------------------------------------------------#
#                              KRAKENZERO                              #
#                                 2023                                 #
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
  
 # title = div(icon("gitkraken", lib = "font-awesome"), " KrakenZero"),
  title = "KrakenZero",
  
  
  tabPanel("Data",
           column(
             wellPanel(
               textAreaInput("dataInput", "Input Scout Data", width = "330px", height = "200px", resize = "none"),
               actionButton("enterData", "Enter"),
               h4("Apply Data?"),
               actionButton("yesData", "Yes", width = '60px'),
               actionButton("noData", "No", width = '60px')
             ),
             width = 3
           ),
           column(
             DTOutput("preview"),
             width = 9
           )
  ),  
  
  tabPanel("Teams",
           column(
             wellPanel(
               
             ),
             wellPanel(
               
             ),
             width = 3
           )
  ),
  
  tabPanel("Matches",
           
  ),
  
  tabPanel("Competition",
           
  ),
  
  tabPanel("Graph",
           
  ),
  
  tabPanel("Match Planner",
           
  ),
  
  tabPanel("Stats",
           
  ),
  
  tabPanel("Schedule"
           
  ),
  
  tabPanel("Functions"
           
  ),
  
  
  id = "main",
  
  selected = "Data",
  
  theme = theme,
  
  tags$script(src="https://kit.fontawesome.com/7f698a1940.js")
)

