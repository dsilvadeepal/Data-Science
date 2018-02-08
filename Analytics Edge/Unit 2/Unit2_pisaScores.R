pisaTrain = read.csv("pisa2009train.csv")
pisaTest = read.csv("pisa2009test.csv")
str(pisaTrain)

tapply(pisaTrain$readingScore, pisaTrain$male, mean)

summary(pisaTrain)

pisaTrain = na.omit(pisaTrain)
pisaTest = na.omit(pisaTest)
str(pisaTrain)
str(pisaTest)


pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White")
pisaTest$raceeth = relevel(pisaTest$raceeth, "White")

lmScore = lm(readingScore ~ ., data = pisaTrain)
summary(lmScore)

RMSE = sqrt(mean(lmScore$residuals^2))
RMSE

predTest = predict(lmScore, newdata = pisaTest)
summary(predTest)