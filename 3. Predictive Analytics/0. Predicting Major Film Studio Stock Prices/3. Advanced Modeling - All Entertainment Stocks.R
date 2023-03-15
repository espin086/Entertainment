#Select ticker to analyze

for(i in 1:length(tickers)){
        ticker.num <- i #you can take this entire set of code out of the loop and manually enter #
        #Creating a filter so modeling is simplified
        my.stock <- stocks.clean[ , grepl( tickers[ticker.num] , names( stocks.clean ) ) ]
        
        #Creating testing and training datasets
        trainig.rows <- nrow(my.stock)*.7
        training <- my.stock[1:trainig.rows, ]
        testing.rows <- trainig.rows + 1
        testing <- my.stock[testing.rows:nrow(my.stock),]
        
        ###################
        #Logistic regresion is the simplest model to interpret
        target <- training[[1]]
        glm.fit <- glm(as.formula(paste(tickers[ticker.num],"~.",collapse="+")), data = training ,family = binomial)
        
        glm.probs = predict(glm.fit, newdata = testing, type="response") #this code will predict on the training data, response outputs the probability 
        glm.probs[1:10]
        hist(glm.probs, col = "red", main = paste0("GLM Probability", "-", tickers[i] )) #probablity that a given stock will go up
        
        #turning the probability of up or down into 1 for up and 0 for down
        glm.pred = rep(0, nrow(testing))
        glm.pred[glm.probs >.5] = 1
        
        ##########################
        #Result of logistic regression
        print(table(glm.pred, testing[[1]]))#Typically the response variable is first
        print(mean(glm.pred == testing[[1]])) #this gives the prediction accuracy in %
        
        
        
}

