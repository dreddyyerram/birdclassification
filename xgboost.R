library(xgboost)
library(readr)
library(stringr)
library(caret)
library(car)
library(e1071)

library(dplyr)    # for some data preperation
library(Ckmeans.1d.dp) # for xgb.ggplot.importance

setwd("C:/Users/hp/Documents/R/ml")
data1 <- read.csv('extractedfeatures.csv', header = TRUE)
data1=data1[-1]
data1=data1[-15]
data1

dat <- data1 
dat$label <- as.numeric(dat$label)
summary(dat$label)
write.csv(dat,file = "ex.csv")

dat$label=dat$label-1



set.seed(100)
# Make split index
train_index <- sample(nrow(data1), 0.75*nrow(data1), replace = FALSE)


# Full data set
data_variables <- as.matrix(dat[,-14])
data_label <- dat[,"label"]
data_matrix <- xgb.DMatrix(data = as.matrix(dat), label = data_label)

# split train data and make xgb.DMatrix
train_data   <- data_variables[train_index,]
train_label  <- data_label[train_index]
train_matrix <- xgb.DMatrix(data = train_data, label = train_label)



# split test data and make xgb.DMatrix
test_data  <- data_variables[-train_index,]
test_label <- data_label[-train_index]
test_matrix <- xgb.DMatrix(data = test_data, label = test_label)


numberOfClasses <- length(unique(dat$label))
xgb_params <- list("objective" = "multi:softprob",
                   "eval_metric" = "mlogloss",
                   "num_class" = numberOfClasses)
nround    <- 50 # number of XGBoost rounds
cv.nfold  <- 5

# Fit cv.nfold * cv.nround XGB models and save OOF predictions
cv_model <- xgb.cv(params = xgb_params,
                   data = train_matrix, 
                   nrounds = nround,
                   nfold = cv.nfold,
                   verbose = FALSE,
                   prediction = TRUE)


OOF_prediction <- data.frame(cv_model$pred) %>%
  mutate(max_prob = max.col(., ties.method = "last"),
         label = train_label + 1)
head(OOF_prediction)



confusionMatrix(factor(OOF_prediction$max_prob),
                factor(OOF_prediction$label),
                mode = "everything")


#building full model
bst_model <- xgb.train(params = xgb_params,
                       data = train_matrix,
                       nrounds = nround)

# Predict hold-out test set
test_pred <- predict(bst_model, newdata = test_matrix)
test_prediction <- matrix(test_pred, nrow = numberOfClasses,
                          ncol=length(test_pred)/numberOfClasses) %>%
  t() %>%
  data.frame() %>%
  mutate(label = test_label + 1,
         max_prob = max.col(., "last"))
# confusion matrix of test set
confusionMatrix(factor(test_prediction$max_prob),
                factor(test_prediction$label),
                mode = "everything")



# get the feature real names
names <-  colnames(dat[,-14])
# compute feature importance matrix
importance_matrix = xgb.importance(feature_names = names, model = bst_model)
head(importance_matrix)
gp = xgb.ggplot.importance(importance_matrix)
print(gp) 


