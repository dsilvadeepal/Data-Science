

#screenName <- c("katyperry", "justinbieber", "rihanna", "taylorswift13", "TheEllenShow")

#checkHandles <- lookupUsers(screenName)


#x <- userTimeline("TheEllenShow",n=3200,includeRts = FALSE)
#x <- searchTwitter('#machinelearning', n = 3200, lang = 'en', resultType = 'popular')

x <- searchTwitter('#Trailheadx', n = 3200, lang = 'en', resultType = 'popular')

HashTagData <- twListToDF(x)
HashTag.df <- data.frame(HashTagData)

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
HashTag <- tm_map(HashTag, removeWords, c(stopwords("english"), "cfalse", "true", "iphonea", "relnofollowmedia", "relnofollowtwitter", "href", "web","clientaa", "clienta"))

wordcloud(HashTag, min.freq = 1, scale=c(6,0.6),colors=brewer.pal(8, "Set1"), random.order = FALSE, max.words = 150)

