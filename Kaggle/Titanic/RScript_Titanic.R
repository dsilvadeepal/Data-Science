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
fancyRpartPlot(fit)
Prediction1 <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction1)
write.csv(submit, file = "mysnippedtree.csv", row.names = FALSE)

#Feature Engineering
test$Survived <- NA
combi <- rbind(train,test)

#Cast Name column back to a text string not as levels
train$Name[1]
combi$Name <- as.character(combi$Name)
combi$Name[1]

strsplit(combi$Name[1], split='[,.]')[[1]][2]

combi$Title <- sapply(combi$Name, FUN=function(x){strsplit(x, split='[,.]')[[1]][2]})
combi$Title <- sub(' ', '', combi$Title)
table(combi$Title)

combi$Title[combi$T %in% c('Mme', 'Mlle')] <- 'Mlle'
combi$Title[combi$T %in% c('Capt', 'Don', 'Major', 'Sir', 'Jonkheer')] <- 'Sir'
combi$Title[combi$T %in% c('Dona', 'Lady', 'the Countess')] <- 'Lady'

combi$Title <- factor(combi$Title)

combi$FamilySize <- combi$SibSp + combi$Parch + 1
combi$Surname <- sapply(combi$Name, FUN=function(x){strsplit(x, split='[,.]')[[1]][1]})
combi$FamilyId <- paste(as.character(combi$FamilySize), combi$Surname, sep = "")
combi$FamilyId[combi$FamilySize <2] <- 'Small'
table(combi$FamilyId)

famIDs <- data.frame(table(combi$FamilyId))
famIDs <- famIDs[famIDs$Freq <= 2, ]

combi$FamilyId[combi$FamilyId %in% famIDs$Var1] <- 'Small'
combi$FamilyId <- factor(combi$FamilyId)

#Split data back to train & test data
train <- combi[1:891,]
test <- combi[892:1309,]

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + 
               Embarked + Title + FamilySize + FamilyId,
             data=train, method="class")
fancyRpartPlot(fit)
Prediction2 <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction2)
write.csv(submit, file = "featureenggtree.csv", row.names = FALSE)

#Random forests

#Fill in the missing Age values
summary(combi$Age)

Agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize,
                data=combi[!is.na(combi$Age),], 
                method="anova")
combi$Age[is.na(combi$Age)] <- predict(Agefit, combi[is.na(combi$Age),])

which(combi$Embarked == '')
combi$Embarked[c(62, 830)] = 'S'
combi$Embarked <- factor(combi$Embarked)

summary(combi$Fare)
which(is.na(combi$Fare))
combi$Fare[1044] <- median(combi$Fare, na.rm = TRUE)


combi$FamilyID2 <- combi$FamilyId
combi$FamilyID2 <- as.character(combi$FamilyID2)
combi$FamilyID2[combi$FamilySize <= 3] <- 'Small'
combi$FamilyID2 <- factor(combi$FamilyID2)

#Split data back to train & test data
train <- combi[1:891,]
test <- combi[892:1309,]

library(randomForest)

set.seed(400)

fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare +
                      Embarked + Title + FamilySize + FamilyID2,
                    data=train, 
                    importance=TRUE, 
                    ntree=2500)

varImpPlot(fit)

Prediction5 <- predict(fit, test)
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction5)
write.csv(submit, file = "firstforest.csv", row.names = FALSE)
