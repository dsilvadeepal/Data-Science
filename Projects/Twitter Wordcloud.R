library(twitteR)
library(ROAuth)
library(stringr)
library(tm)
library(wordcloud)

consumer_key <- "mftPn6qtOfCL46fzJY3pTeVI4"
consumer_secret <- "x5D1VIlV1O4TkZPshj31j88CutI8X2eSfgryy0pdMpDJjUTcKK"
access_token <- "2924790128-WORx3u9bTwDqAYr6zSanDnDlafLaSHBdzVKYZxC"
access_secret <- "aMFTRClgP3Q2K0pJ21p1fromq1OWx4cS1hU6i4qJyqpZb"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)