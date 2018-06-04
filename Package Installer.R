install <- function(packages){
  new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  if (length(new.packages)) 
    install.packages(new.packages, dependencies = TRUE)
  sapply(packages, require, character.only = TRUE)
}

# usage
required.packages <- c("ggplot2", "dplyr", "reshape2", "devtools", "tidyverse", "caret","randomForest","knitr", 
                       "stringr","tidyr", "leaflet","ggmap", "lubridate", "readxl", "readr","rvest", "magrittr" )
install(required.packages)