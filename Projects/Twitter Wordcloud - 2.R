#http://rstudio-pubs-static.s3.amazonaws.com/71296_3f3ee76e8ef34410a1635926f740c473.html

library(twitteR)
library(ROAuth)
library(stringr)
library(tm)
library(wordcloud2)
library(tidytext)
library(tidyverse)
library(dplyr)

consumer_key <- "mftPn6qtOfCL46fzJY3pTeVI4"
consumer_secret <- "x5D1VIlV1O4TkZPshj31j88CutI8X2eSfgryy0pdMpDJjUTcKK"
access_token <- "2924790128-WORx3u9bTwDqAYr6zSanDnDlafLaSHBdzVKYZxC"
access_secret <- "aMFTRClgP3Q2K0pJ21p1fromq1OWx4cS1hU6i4qJyqpZb"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


#tweets <- searchTwitter("#datascience",n=3000,lang="en", resultType = "popular")
tweets <- userTimeline("dsilvadeepal",n=3200,includeRts = FALSE)

tweets.txt <- sapply(tweets, function(t)t$getText())
tweets.txt <- str_replace_all(tweets.txt,"[^[:graph:]]", " ") 


clean.text = function(x)
{
  
  # tolower
  x = tolower(x)
  # remove rt
  x = gsub("rt", "", x)
  # remove at
  x = gsub("@\\w+", "", x)
  # remove punctuation
  x = gsub("[[:punct:]]", "", x)
  # remove numbers
  x = gsub("[[:digit:]]", "", x)
  # remove links http
  x = gsub("http\\w+", "", x)
  # remove tabs
  x = gsub("[ |\t]{2,}", "", x)
  # remove blank spaces at the beginning
  x = gsub("^ ", "", x)
  # remove blank spaces at the end
  x = gsub(" $", "", x)
  
  return(x)
}

clean_tweet <- clean.text(tweets.txt)
inspect(clean_tweet)
wordsToRemove <- c(stopwords('en'), 'tco', 'https')

tweets <- Corpus(VectorSource(clean_tweet))
clean_tweet <- tm_map(tweets, removeWords, wordsToRemove)
dtm <- TermDocumentMatrix(clean_tweet, control = list(wordLengths = c(1, Inf)))
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)


wordcloud2(d, shape = "triangle", color="random-light",
           minRotation = -pi/4, maxRotation = -pi/4, size = 0.5)
