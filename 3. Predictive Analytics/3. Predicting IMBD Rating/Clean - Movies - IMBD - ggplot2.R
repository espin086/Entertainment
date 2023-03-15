

#Importing IMBD ggplot 2 Movie Data
setwd("~/Documents/HollywoodModels/0. Data/1. Raw Data ")

#Importing movie data
#title. Title of the movie.     
#year. Year of release.     
#budget. Total budget (if known) in US dollars     
#length. Length in minutes.     
#rating. Average IMDB user rating.     
#votes. Number of IMDB users who rated this movie.     
#r1-10. Multiplying by ten gives percentile (to nearest 10%) of users who rated this movie a 1.     
#mpaa. MPAA rating.     
#action, animation, comedy, drama, documentary, romance, short. Binary variables representing if movie was classified as belonging to that genre.

df <- read.csv("Movies - IMBD - ggplot2.csv")
df <- df[,-1]

#Summary from exploratory analysis
summary(df)

#There appear to be multiple movies per title, these are not errors
alice <- df[which(df$title == "Alice in Wonderland"),]

#Movies go from 1893 to 2005, may want to potentially drop older movies
hist(df$year)

#There are some short-fils as well as extremely long films, may want to use short variable to filter out shorts
summary(df$length)
short <- df[which(df$length == 1),]
long <- df[which(df$length == 5220),]

#The majority of films don't have budget data, may want to drop these films first
summary(df$budget)

#The majority also don't have MPAA ratings, may want to drop these?
summary(df$mpaa)

#Subsetting data based on completeness
df.small <- df[which(df$Short != 1 & df$mpaa != "" & !is.na(df$budget)),]


#########################
#Writing clean data to clean data folder
setwd("~/Documents/HollywoodModels/0. Data/2. Clean Data")

write.csv(df.small, "Clean - Movies - IMBD - ggplot2.csv", row.names = FALSE)
