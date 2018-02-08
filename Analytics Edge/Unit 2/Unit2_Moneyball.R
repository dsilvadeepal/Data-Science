
baseball = read.csv("baseball.csv")
str(baseball)

moneyball = subset(baseball, Year < 2002)
str(moneyball)

moneyball$RD = moneyball$RS - moneyball$RA

plot(moneyball$RD, moneyball$W)

WinsReg = lm(W ~ RD, data=moneyball)
summary(WinsReg)

RunsReg = lm(RS ~ OBP + SLG + BA, data=moneyball)
summary(RunsReg)

RunsReg = lm(RS ~ OBP + SLG, data=moneyball)
summary(RunsReg)