songs = read.csv("songs.csv")
str(songs)

#1. How many observations (songs) are from the year 2010?
#373
table(songs$year)

#2. How many songs does the dataset include for which the artist name is "Michael Jackson"?
#18
sum(songs$artistname == "Michael Jackson")

#OR Create a subset for songs where artist is MJ
MichaelJackson = subset(songs, artistname == "Michael Jackson")
nrow(MichaelJackson)

#3. Which of these songs by Michael Jackson made it to the Top 10? Select all that apply.
# You Rock My World & You Are Not Alone
MichaelJackson$songtitle
MichaelJackson[c(“songtitle”, “Top10”)]

#4. The variable corresponding to the estimated time signature (timesignature) is discrete, meaning that it only takes integer values (0, 1, 2, 3, . . . ). 
#What are the values of this variable that occur in our dataset? Select all that apply.
# 0, 1, 3, 4, 5, 7

#Which timesignature value is the most frequent among songs in our dataset?  
# 4
table(songs$timesignature)

#5. Out of all of the songs in our dataset, the song with the highest tempo is one of the following songs. Which one is it?
# Wanna Be Startin' Somethin'
which.max(songs$tempo)
songs$songtitle[6206]




