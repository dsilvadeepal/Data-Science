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






