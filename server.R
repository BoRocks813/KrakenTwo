#-----------------------------------------------------------------------
# KRAKENZERO
# 
# Created by Will Brittian of Team 6672
#-----------------------------------------------------------------------


#
# The server function is where the majority of the
# functions necessary to run KrakenZero are called
# 


# Imports
library(shiny)

source("ui.R")
source("dataframes.R")


# Physically creating the server function
server <- function(input, output, session) {
  observeEvent(input$yesData, {
    print(vals$test)
  })
  
  observeEvent(input$noData, {
    vals$test <- "goodbye"
  })
}