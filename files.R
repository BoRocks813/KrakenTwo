#-----------------------------------------------------------------------
# KRAKENZERO
# 
# Created by Will Brittian of Team 6672
#-----------------------------------------------------------------------


# This file contains functions pertaining to saving/editing files
# beyond the scope of the program

source("config.R")

createFile <- function(fileName, path) {
  if(path == "d") {
    write.csv(data.frame(), filePath, row.names = F)
  }
}