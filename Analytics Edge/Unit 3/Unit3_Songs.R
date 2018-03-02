songs = read.csv("songs.csv")
str(songs)

#1.1 How many observations (songs) are from the year 2010?
#373
table(songs$year)

#1.2 How many songs does the dataset include for which the artist name is "Michael Jackson"?
#18
sum(songs$artistname == "Michael Jackson")

#OR Create a subset for songs where artist is MJ
MichaelJackson = subset(songs, artistname == "Michael Jackson")
nrow(MichaelJackson)

#1.3 Which of these songs by Michael Jackson made it to the Top 10? Select all that apply.
# You Rock My World & You Are Not Alone
MichaelJackson$songtitle
MichaelJackson[c(“songtitle”, “Top10”)]

#1.4 The variable corresponding to the estimated time signature (timesignature) is discrete, meaning that it only takes integer values (0, 1, 2, 3, . . . ). 
#What are the values of this variable that occur in our dataset? Select all that apply.
# 0, 1, 3, 4, 5, 7

#1.5 Which timesignature value is the most frequent among songs in our dataset?  
# 4
table(songs$timesignature)

#1.6 Out of all of the songs in our dataset, the song with the highest tempo is one of the following songs. Which one is it?
# Wanna Be Startin' Somethin'
which.max(songs$tempo)
songs$songtitle[6206]

#2. Creating Our Prediction Model
#We wish to predict whether or not a song will make it to the Top 10. 
#To do this, first use the subset function to split the data into a training set "SongsTrain" consisting of all the observations
# up to and including 2009 song releases, and a testing set "SongsTest", consisting of the 2010 song releases.

#2.1 How many observations (songs) are in the training set?
#7201
SongsTrain = subset(songs, year < 2010)
SongsTest = subset(songs, year == 2010)
str(SongsTrain)

#2.2 Build a logistic regression model to predict Top10 using all of the other variables as the independent variables
#We will only use the variables in our dataset that describe the numerical attributes of the song in our logistic regression model. 
#So we won't use the variables "year", "songtitle", "artistname", "songID" or "artistID".

nonvars = c("year", "songtitle", "artistname", "songID", "artistID")

SongsTrain = SongsTrain[ , !(names(SongsTrain) %in% nonvars) ]
SongsTest = SongsTest[ , !(names(SongsTest) %in% nonvars) ]

#Looking at the summary of your model, what is the value of the Akaike Information Criterion (AIC)?
#AIC: 4827.2

SongsLog1 = glm(Top10 ~ ., data=SongsTrain, family=binomial)
summary(SongsLog1)

#2.3 The higher our confidence about time signature, key and tempo, the more likely the song is to be in the Top 10 correct

#2.4 In general, if the confidence is low for the time signature, tempo, and key, then the song is more likely to be complex. 
#What does Model 1 suggest in terms of complexity?
#Since the coefficient values for timesignature_confidence, tempo_confidence, and key_confidence are all positive, lower confidence leads to a lower predicted probability of a song being a hit. 
#So mainstream listeners tend to prefer less complex songs.

#2.5 By inspecting the coefficient of the variable "loudness", what does Model 1 suggest?
#Mainstream listeners prefer songs with heavy instrumentation correct
# the coefficient estimate for energy is negative, meaning that mainstream listeners prefer songs that are less energetic, which are those with light instrumentation
#These coefficients lead us to different conclusions!

#3.1 What is the correlation between the variables "loudness" and "energy" in the training set?
#0.73991
cor(SongsTrain$loudness, SongsTrain$energy)

#3.2 Create Model 2, which is Model 1 without the independent variable "loudness".
SongsLog2 = glm(Top10 ~ . - loudness, data=SongsTrain, family=binomial)
summary(SongsLog2)

#The coefficient estimate for energy is positive in Model 2, suggesting that songs with higher energy levels tend to be more popular.
#However, note that the variable energy is not significant in this model.

#3.3 Now, create Model 3, which should be exactly like Model 1, but without the variable "energy".
SongsLog3 = glm(Top10 ~ . - energy, data=SongsTrain, family=binomial)
summary(SongsLog3)

#We can see that loudness has a positive coefficient estimate, meaning that our model predicts that songs with heavier instrumentation tend to be more popular


#4.1 Make predictions on the test set using Model 3. What is the accuracy of Model 3 on the test set, using a threshold of 0.45?
predictTest = predict(SongsLog3, newdata = SongsTest, type="response")
table(SongsTest$Top10, predictTest >= 0.45)
#The accuracy of the model is (309+19)/(309+5+40+19) = 0.87936


#4.2 Let's check if there's any incremental benefit in using Model 3 instead of a baseline model.
#What would the accuracy of the baseline model be on the test set? 
table(SongsTest$Top10)
#The baseline model would get 314 observations correct, and 59 wrong, for an accuracy of 314/(314+59) = 0.8418231.

#4.3 How many songs does Model 3 correctly predict as Top 10 hits in 2010 (remember that all songs in 2010 went into our test set), using a threshold of 0.45?
table(SongsTest$Top10, testPredict >= 0.45)
#19
#How many non-hit songs does Model 3 predict will be Top 10 hits (again, looking at the test set), using a threshold of 0.45?
#5

#We have 19 true positives (Top 10 hits that we predict correctly), 
#and 5 false positives (songs that we predict will be Top 10 hits, but end up not being Top 10 hits).


#4.4 What is the sensitivity of Model 3 on the test set, using a threshold of 0.45?
#What is the specificity of Model 3 on the test set, using a threshold of 0.45?
table(SongsTest$Top10, testPredict >= 0.45)
#Using the confusion matrix
We can compute the sensitivity to be 19/(19+40) = 0.3220339, and the specificity to be 309/(309+5) = 0.9840764.

#4.5 Validating Our Model
#Model 3 favors specificity over sensitivity
#Model 3 provides conservative predictions, and predicts that a song will make it to the Top 10 very rarely. So while it detects less than half of the Top 10 songs, we can be very confident in the songs that it does predict to be Top 10 hits.
