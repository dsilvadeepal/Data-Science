

#Then, split the data into a training set, consisting of all the observations up to and including 2006, and a testing set consisting of the remaining years (hint: use subset). A training set refers to the data that will be used to build the model (this is the data we give to the lm() function), and a testing set refers to the data we will use to test our predictive ability.

#Next, build a linear regression model to predict the dependent variable Temp, using MEI, CO2, CH4, N2O, CFC.11, CFC.12, TSI, and Aerosols as independent variables (Year and Month should NOT be used in the model). Use the training set to build the model.

climate = read.csv("climate_change.csv")
train = subset(climate, Year <= 2006)
test = subset(climate, Year > 2006)
climatelm = lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data=train)
summary(climatelm)

#Find the correlation
cor(train)

climatelm1 = lm(Temp ~ MEI + N2O + TSI + Aerosols, data=train)
summary(climatelm1)

StepModel = step(climatelm)

summary(StepModel)

#Using the model produced from the step function, calculate temperature predictions for the testing data set, using the predict function.

#Enter the testing set R2:

temppredict = predict(StepModel, newdata=test)
SSE = sum((temppredict - test$Temp)^2)
SST = sum((mean(train$Temp) - test$Temp)^2) 
R1 = 1- SSE/SST
R1