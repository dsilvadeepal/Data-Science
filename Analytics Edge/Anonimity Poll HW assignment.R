#Read and summarize data

poll = read.csv("AnonymityPoll.csv")
str(poll)
summary(poll)

#How many use a smartphone?
table(poll$Smartphone)

#Which of the following are states in the Midwest census region?
table(poll$State, poll$Region)

#How many interviewees reported not having used the Internet and not having used a smartphone?
#How many interviewees reported having used the Internet and having used a smartphone?
#How many interviewees reported having used the Internet but not having used a smartphone?
#How many interviewees reported having used a smartphone but not having used the Internet?
table(poll$Internet.Use, poll$Smartphone)


#Use the subset function to obtain a data frame called "limited", which is limited to interviewees who reported Internet use or who reported smartphone use
limited = subset(poll, Internet.Use == 1 | Smartphone == 1)
str(limited)

#How many interviewees reported a value of 0 for Info.On.Internet?
#How many interviewees reported the maximum value of 11 for Info.On.Internet?
table(limited$Info.On.Internet)

#What proportion of interviewees who answered the Worry.About.Info question worry about how much information is available about them on the Internet?
#386+404=790  386/790 = 0.4886
table(limited$Worry.About.Info)


#Build a histogram of the age of interviewees. What is the best represented age group in the population?
hist(limited$Age)

max(table(limited$Age, limited$Info.On.Internet))

jitter(c(1, 2, 3))

plot(jitter(limited$Age), jitter(limited$Info.On.Internet))

#Use the tapply() function to obtain the summary of the Info.On.Internet value, broken down by whether an interviewee is a smartphone user.
#What is the average Info.On.Internet value for smartphone users? 4.368
#What is the average Info.On.Internet value for non-smartphone users? 2.923
tapply(limited$Info.On.Internet, limited$Smartphone, summary)


Similarly for Tried.Masking.Identity
tapply(limited$Tried.Masking.Identity, limited$Smartphone, summary)

