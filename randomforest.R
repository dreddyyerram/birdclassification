
library(randomForest)
setwd("C:/Users/hp/Documents/R/ml")
data1 <- read.csv('extractedfeatures.csv', header = TRUE)
data1=data1[-1]
data1=data1[-15]
set.seed(100)
train <- sample(nrow(data1), 0.7*nrow(data1), replace = FALSE)
TrainSet <- data1[train,]
ValidSet <- data1[-train,]
model1 <- randomForest(label ~ ., data = TrainSet,ntree = 500, mtry = 3, importance = TRUE)
model1
predTrain <- predict(model1, TrainSet, type = "class")
# Checking classification accuracy
table(predTrain, TrainSet$label) 

predValid <- predict(model1, ValidSet, type = "class")
# Checking classification accuracy
mean(predValid == ValidSet$label)                    
table(predValid,ValidSet$label)


