#Deepal DSilva  2/6/2018
#http://trevorstephens.com/kaggle-titanic-tutorial/r-part-1-booting-up/
#http://trevorstephens.com/kaggle-titanic-tutorial/r-part-2-the-gender-class-model/

# Set working directory and import datafiles

setwd("C:/Users/dsilv/Desktop/Learning/Data Science/Data-Science/Kaggle/Titanic")
train <- read.csv("C:/Users/dsilv/Desktop/Learning/Data Science/Data-Science/Kaggle/Titanic/train.csv")
test <- read.csv("C:/Users/dsilv/Desktop/Learning/Data Science/Data-Science/Kaggle/Titanic/test.csv")

#All perish prediction
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "theyallperish.csv", row.names = FALSE)

#Gender Age factor
summary(train$Sex)
prop.table(table(train$Sex, train$Survived),1)
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "onlyfemalessurvive.csv", row.names = FALSE)

aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'
table(train$Fare2)

aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

#Import rpart i.e. Recursive Partitioning and Regression Trees
#Using Decision Trees
library(rpart)
fit <- rpart(Survived ~ Pclass + Sex + Age +  SibSp + Parch + Fare + Embarked, data=train, method="class")

library(rpart.plot)
library(RColorBrewer)
library(rattle)
fancyRpartPlot(fit)

Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

#Manually trim a decision tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=2, cp=0.005))