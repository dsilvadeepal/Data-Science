parole = read.csv("parole.csv")
str(parole)

#How many of the parolees in the dataset violated the terms of their parole?
#78
table(parole$violator)

#Convert State & Crime to factors
parole$state = as.factor(parole$state)
parole$crime = as.factor(parole$crime)

#Set Seed & Split
set.seed(144)
library(caTools)
split = sample.split(parole$violator, SplitRatio = 0.7)
train = subset(parole, split == TRUE)
test = subset(parole, split == FALSE)

#Logistic Regression Model
mod = glm(violator~. , data=train, family = "binomial")
summary(mod)


predictions = predict(mod, newdata=test, type="response")
summary(predictions)

#Evaluate the model's predictions on the test set using a threshold of 0.5.
table(test$violator, as.numeric(predictions >= 0.5))

#What is the model's sensitivity? 0.522
#What is the model's specificity? 0.933
#What is the model's accuracy? 0.886

#The accuracy (percentage of values on the diagonal) is (167+12)/202 = 0.886. 
#The sensitivity (proportion of the actual violators we got correct) is 12/(11+12) = 0.522.
#Specificity (proportion of the actual non-violators we got correct) is 167/(167+12) = 0.933.

table(test$violator)
#you can see that there are 179 negative examples, which are the ones that the baseline model would get correct. 
#Thus the baseline model would have an accuracy of 179/202 = 0.886.

library(ROCR)
pred = prediction(predictions, test$violator)
as.numeric(performance(pred, "auc")@y.values)
