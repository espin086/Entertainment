#Create data in forms of returns
library(zoo)
library(reshape)
library(DataCombine)
library(quantmod)

#renaming stocks dataset to keep original untouched
stocks.clean <- stocks

#Calculating losses and gains
tickers <- names(stocks.clean)

#Creating set of 'up or down indicators
for (i in 1:length(tickers)){
        stocks.clean[i] <- Delt(stocks.clean[i], type = "log") #Calculating 
        stocks.clean[i][stocks.clean[i] > 0] <- 1 #dummy variable for price change
        stocks.clean[i][stocks.clean[i] < 0] <- 0 #dummy variable for price change
                for (j in 1:7){#looping to lag variable
                        stocks.clean <- slide(stocks.clean, Var = names(stocks.clean[i]), slideBy = -j)   
                }
}

#keeping only complete cases so modeling will work
stocks.clean <- stocks.clean[complete.cases(stocks.clean),]






