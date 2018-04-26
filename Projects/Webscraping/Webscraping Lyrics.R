library(tidyverse)
library(rvest)
 
base_url <- "https://www.billboard.com/charts/greatest-of-all-time-pop-songs-artists"
billboard <- data.frame()

webpage <- read_html(base_url)

artist <- html_nodes(webpage, ".chart-row__artist")
artist <- as.character(html_text(artist))

rank <- html_nodes(webpage, ".chart-row__rank")
rank <- as.numeric(html_text(rank))

top_artists <- data.frame('Artist' = artist,
           'Rank' = rank) %>%
  filter(rank <= 10)

#################
# Extracting Popular Songs
#################

genius_url <- "https://genius.com/artists/Bruno-mars"

genius_page <- read_html(genius_url)
song_links <- html_nodes(genius_page, ".mini_card_grid-song a") %>%
    html_attr("href") 



#Extracting Lyrics

lyrics <- c()


# Get lyrics via for loop
for (i in 1:3) {
  
  # Get page lyrics
  intermediate <- read_html(song_links[i]) %>%
    html_nodes("div.lyrics p") %>%
    html_text()
  
  # Add that onto the empty vector
  lyrics <- append(lyrics, intermediate)
  
}



lyrics[3]



