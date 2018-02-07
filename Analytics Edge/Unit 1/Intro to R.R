#Intro R session

getwd()
WHO = read.csv("WHO.csv")
str(WHO)
summary(WHO)
summary(WHO$Over60)
which.min(WHO$Over60)
WHO$Country[183]
summary(WHO$LiteracyRate)
which.max(WHO$LiteracyRate)
WHO$Country[44]
hist(WHO$CellularSubscribers)
boxplot(WHO$LifeExpectancy ~ WHO$Region)
boxplot(WHO$LifeExpectancy ~ WHO$Region, xlab="", ylab="Life Expectancy", main="Life Expectancy of Countries by Region")
table(WHO$Region)
tapply(WHO$Over60, WHO$Region, mean)
tapply(WHO$LiteracyRate, WHO$Region, min, na.rm=TRUE)