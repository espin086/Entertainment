library(caret) #used to train models
library(caret)#machine learning modeling
library(doMC)
registerDoMC(cores = 4)

set.seed(2015)

#reading in training and test set
setwd("~/Documents/HollywoodModels/0. Data/2. Clean Data")
df <- read.csv("TDM_Scripts.csv")

inBuild <- createDataPartition(y = df$target, p=0.7, list=FALSE)
test <- df[-inBuild,]
train <- df[inBuild,]


#######################################
#Training Methodology

fitControl <- trainControl(## 10-fold CV
        method = "repeatedcv",
        number = 7,
        ## repeated ten times
        repeats = 10)

tunelength <- 7


#######################################
#Level 1 Models - on training data

model.1 <- train(target ~ ., 
                 method="xgbTree",
                 trControl = fitControl, 
                 data = train,
                 tuneLength = tunelength)


model.2 <- train(target ~ ., 
                 method="rf", 
                 trControl = fitControl,
                 data = train,
                 tuneLength = tunelength)

model.3 <- train(target ~ ., 
                 method="knn", 
                 trControl = fitControl,
                 data = train,
                 tuneLength = tunelength)

model.4 <- train(target ~ ., 
                 method="svmLinear", 
                 trControl = fitControl,
                 data = train,
                 tuneLength = tunelength)

#Creating new data based for ensemble models
train$model.1 <- predict(model.1, train)
train$model.2 <- predict(model.2, train)
train$model.3 <- predict(model.3, train)
train$model.4 <- predict(model.4, train)




#######################################
#Level 1 - Ensemble Models - for greater accuracy

#Training ensemble models on the training set with other model's predictors
ensemble.1 <- train(target ~ ., 
                    method ="xgbTree", 
                    trControl = fitControl,
                    data = train,
                    tuneLength = tunelength)

ensemble.2 <- train(target ~ ., 
                    method="rf", 
                    trControl = fitControl,
                    data = train,
                    tuneLength = tunelength)

ensemble.3 <- train(target ~ ., 
                    method="knn", 
                    trControl = fitControl,
                    data = train,
                    tuneLength = tunelength)

ensemble.4 <- train(target ~ ., 
                    method="svmLinear", 
                    trControl = fitControl,
                    data = train,
                    tuneLength = tunelength)

train$ensemble.1 <- predict(ensemble.1, train)
train$ensemble.2<- predict(ensemble.2, train)
train$ensemble.3 <- predict(ensemble.3, train)
train$ensemble.4 <- predict(ensemble.4, train)




#######################################
#Level 2 - Ensemble Models

final.ensemble <- train(target ~ ., 
                        method="xgbTree",
                        trControl = fitControl,
                        data = train,
                        tuneLength = tunelength)
final.ensemble


#######################################
#Accessing Model Accuracy on test data
test$model.1 <- predict(model.1, test)
test$model.2 <- predict(model.2, test)
test$model.3 <- predict(model.3, test)
test$model.4 <- predict(model.4, test)
test$ensemble.1 <- predict(ensemble.1, test)
test$ensemble.2 <- predict(ensemble.2, test)
test$ensemble.3 <- predict(ensemble.3, test)
test$ensemble.4 <- predict(ensemble.4, test)
test$final.ensemble <- predict(final.ensemble, test)



#Out of Sample Error: 1) Predict on test set and examine confusion matrix
confusionMatrix(test$target, test$model.1)
confusionMatrix(test$target, test$model.2)
confusionMatrix(test$target, test$model.3)
confusionMatrix(test$target, test$model.4)

confusionMatrix(test$target, test$ensemble.1)
confusionMatrix(test$target, test$ensemble.2)
confusionMatrix(test$target, test$ensemble.3)
confusionMatrix(test$target, test$ensemble.4)

confusionMatrix(test$target, test$final.ensemble)

#Additional data on the tuning of the model
plot(model.1)
plot(model.2)
plot(model.3)
plot(model.4)

plot(ensemble.1)
plot(ensemble.2)
plot(ensemble.3)
plot(ensemble.4)

#Histogram of model accuracy
model.1.resample <- model.1$resample
model.2.resample <- model.2$resample
model.3.resample <- model.3$resample
model.4.resample <- model.4$resample

hist(model.1.resample$Accuracy)
hist(model.2.resample$Accuracy)
hist(model.3.resample$Accuracy)
hist(model.4.resample$Accuracy)



