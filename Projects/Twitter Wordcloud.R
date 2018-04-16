library(twitteR)
library(tm)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)

consumer_key <- "mftPn6qtOfCL46fzJY3pTeVI4"
consumer_secret <- "x5D1VIlV1O4TkZPshj31j88CutI8X2eSfgryy0pdMpDJjUTcKK"
access_token <- "2924790128-WORx3u9bTwDqAYr6zSanDnDlafLaSHBdzVKYZxC"
access_secret <- "aMFTRClgP3Q2K0pJ21p1fromq1OWx4cS1hU6i4qJyqpZb"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tweets <- searchTwitter("#RampageMovie",n=3000,lang="en", resultType = "popular")
tweets.txt <- sapply(tweets, function(t)t$getText())
tweets.txt <- str_replace_all(tweets.txt,"[^[:graph:]]", " ") 


docs <- Corpus(VectorSource(tweets.txt))
inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("tco", "https")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)


dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)


wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

wordcloud2(d, shape = "cardioid")

letterCloud(d, word = "R")

