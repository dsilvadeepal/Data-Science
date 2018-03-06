loans = read.csv("loans.csv")
str(loans)

table(loans$not.fully.paid)
#What proportion of the loans in the dataset were not paid in full?
#0.1600543

loans = read.csv("loans_imputed.csv")

#Split the data
library(caTools)
set.seed(144)
spl = sample.split(loans$not.fully.paid, 0.7)
train = subset(loans, spl == TRUE)
test = subset(loans, spl == FALSE)

mod = glm(not.fully.paid~., data=train, family="binomial")
summary(mod)

#Confusion Matrix
test$predicted.risk = predict(mod, newdata=test, type="response")
table(test$not.fully.paid, test$predicted.risk > 0.5)

library(ROCR)
pred = prediction(test$predicted.risk, test$not.fully.paid)
as.numeric(performance(pred, "auc")@y.values)

#Bivariate model
bivariate = glm(not.fully.paid~int.rate, data=train, family="binomial")
summary(bivariate)

pred.bivariate = predict(bivariate, newdata=test, type="response")
summary(pred.bivariate)

prediction.bivariate = prediction(pred.bivariate, test$not.fully.paid)
as.numeric(performance(prediction.bivariate, "auc")@y.values)
