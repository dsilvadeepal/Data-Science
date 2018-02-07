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