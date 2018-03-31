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

#screenName <- c("katyperry", "justinbieber", "rihanna", "taylorswift13", "TheEllenShow")

#checkHandles <- lookupUsers(screenName)


#x <- userTimeline("katyperry",n=3200,includeRts = FALSE)
#x <- searchTwitter('#machinelearning', n = 3200, lang = 'en', resultType = 'popular')

x <- searchTwitter('#IoT', n = 3200, lang = 'en', resultType = 'popular')

HashTagData <- twListToDF(x)
HashTag.df <- data.frame(KPerryData)

unclean_tweets <- data.frame()
unclean_tweets <- HashTag.df

iconv(unclean_tweets, from="UTF-8", to="ASCII", sub="")
clean_tweet <-  str_replace_all(unclean_tweets,"[^[:graph:]]", " ")
clean_tweet <- gsub("[^[:alnum:]///' ]", "", clean_tweet)


clean_tweet = gsub("&amp", "", clean_tweet)
clean_tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", clean_tweet)
clean_tweet <- tolower(clean_tweet)
clean_tweet = gsub("@\\w+", "", clean_tweet)
clean_tweet = gsub("[[:punct:]]", "", clean_tweet)
clean_tweet = gsub("[[:digit:]]", "", clean_tweet)
clean_tweet = gsub("http\\w+", "", clean_tweet)
clean_tweet = gsub("[ \t]{2,}", "", clean_tweet)
clean_tweet = gsub("^\\s+|\\s+$", "", clean_tweet) 


HashTag <- Corpus(VectorSource(clean_tweet))
HashTag <- tm_map(HashTag, content_transformer(tolower))
HashTag <- tm_map(HashTag, removeWords, c(stopwords("english"), "false", "true", "iphonea", "relnofollowtweetdecka", "relnofollowtwitter", "href", "web","clientaa", "clienta"))

wordcloud(HashTag, min.freq = 3, scale=c(4,0.5),colors=brewer.pal(8, "Set1"), random.order = FALSE, max.words = 100)

