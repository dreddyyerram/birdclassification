library(e1071)
library(car)
library(corrplot)


setwd("C:/Users/hp/Documents/R/ml")
data1 <- read.csv('extractedfeatures.csv', header = TRUE)
data1=data1[-1]
data1=data1[-15]
#Finding missing values
summary(is.na(data1))



for(i in 1:ncol(data1[-14])){

x=data.frame(data1[14],data1[i])
plot(x)
}











#function for finf=ding significance in correlation
cor.mtest <- function(mat, ...) {
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat<- matrix(NA, n, n)
  diag(p.mat) <- 0
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(mat[, i], mat[, j], ...)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
    }
  }
  colnames(p.mat) <- rownames(p.mat) <- colnames(mat)
  p.mat
}





#correlation matrix


M=head(data1)
M=cor(data1[-14])


p.mat <- cor.mtest(M)
head(p.mat[, 1:5])

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(M, method="color", col=col(200),  
         type="upper", order="hclust", 
         addCoef.col = "black", # Add coefficient of correlation
         tl.col="black", tl.srt=45, #Text label color and rotation
         # Combine with significance
         p.mat = p.mat, sig.level = 0.01, insig = "blank", 
         # hide correlation coefficient on the principal diagonal
         diag=FALSE 
)


corrplot(M, type="upper", order="hclust", col=c("black", "white"),
         bg="lightblue")





set.seed(100)
train <- sample(nrow(data1), 0.75*nrow(data1), replace = FALSE)
TrainSet <- data1[train,]
ValidSet <- data1[-train,]


svm1 <- svm(label ~ ., data=TrainSet, 
            method="C-classification", kernal="radial", 
            gamma=0.1, cost=10)
summary(svm1)

prediction <- predict(svm1, ValidSet)
xtab <- table(ValidSet$label, prediction)
xtab
accuracy=mean(prediction == ValidSet$label)
accuracy



