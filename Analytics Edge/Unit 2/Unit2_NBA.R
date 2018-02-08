NBA = read.csv("NBA_train.csv")
str(NBA)

table(NBA$W, NBA$Playoffs)

NBA$PTSdiff = NBA$PTS - NBA$oppPTS
plot(NBA$PTSdiff, NBA$W)

WinsReg = lm(W ~ PTSdiff, data=NBA)
summary(WinsReg)

PointsReg = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + TOV + STL + BLK, data =NBA)
summary(PointsReg)
PointsReg$residuals
SSE = sum(PointsReg$residuals ^2)
SSE
RMSE = sqrt(SSE/nrow(NBA))
RMSE
mean(NBA$PTS)

PointsReg2 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + STL + BLK, data =NBA)
summary(PointsReg2)

PointsReg3 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL + BLK, data =NBA)
summary(PointsReg3)

PointsReg4 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL, data =NBA)
summary(PointsReg4)
SSE_4 = sum(PointsReg4$residuals ^ 2)
SSE_4
RMSE_4 = sqrt(SSE_4/nrow(NBA))
RMSE_4

#Prediction on the test data
NBA_test = read.csv("NBA_test.csv")
PointsPredictions = predict(PointsReg4, newdata = NBA_test)
SSE = sum((PointsPredictions - NBA_test$PTS)^2)
SST = sum((mean(NBA$PTS) - NBA_test$PTS)^2)
R2 = 1-SSE/SST
R2
RMSE = sqrt(SSE/nrow(NBA_test))
RMSE