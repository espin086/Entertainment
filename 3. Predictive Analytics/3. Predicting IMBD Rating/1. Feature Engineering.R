
#Importing My ToolBox
setwd("~/Documents/my-toolbox/3. Machine Learning Models")
source("0. Source Code - Prep Data.R")

#Setting working directory to IMDB Data"
setwd("~/Documents/HollywoodModels/0. Data/1. Raw Data ")
df <- read.csv("Movies - IMBD - ggplot2.csv")

#Prepping data
prep.data(dataframe = df, target = df$rating)

#Saving Combination of feature engineered datasets
setwd("~/Documents/HollywoodModels/0. Data/1. Raw Data ")