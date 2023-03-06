# load libraries & data----------
library(tidyverse)
library(ggplot2)
library(quanteda)
library(quanteda.textstats)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)

messages <- read_csv("data/Remerciements - Sheet1.csv")

#Text Preparation --------------
messagesCorpus <- corpus(messages$Remerciement)

#turn corpus into document-feature matrix
dfm <- messagesCorpus %>%
  tokens(remove_numbers=T,
         remove_punct=T,
         include_docvars=T,
         remove_symbols = T) %>%
  tokens_remove(stopwords("fr")) %>%
  dfm(tolower=T)%>%
  dfm_tfidf()

#remove other words
dfm2 <- dfm %>% 
  dfm_remove(c("très", "j'ai", "tout", "vraiment", "c'est", "a", "ça", "comme", "plus", "faites"))


#returns a data.frame object, making it easier to use the output for further analyses
messages_df <- textstat_frequency(dfm2, force = TRUE)

#include colours for plotting
messages_df <- messages_df%>%
  mutate(color = case_when(feature == "merci" ~ "red",
                           TRUE ~ "white"))


#Visualization -----------


#plot 1 {wordcloud}
plot1 <- wordcloud(words = messages_df$feature, freq = messages_df$frequency, 
          max.words=100, 
          random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"),
          scale=c(2.5,.25))
plot1


#plot 2 {wordcloud2} MIEUX
plot2 <- wordcloud2(messages_df, 
                    size=0.5,
                    color='random-dark')
plot2

#plot 3 custom
figpath = "data/heart.png"
col = messages_df$color

plot3 <-  wordcloud2(messages_df[0:75,],
                     #figPath = figpath,    can't make it work (??)
                     shape = "triangle-forward",
                     size=0.5,
                     backgroundColor = "black",
                     color = col[0:75])
plot3

#TUTO: https://cran.r-project.org/web/packages/wordcloud2/vignettes/wordcloud.html

#IDEES: 
  #logo equipage solidaire (fist) as a mask (ou coeur) -> using "figpath"
  #fond noir, tous les mots en blanc SAUF 'merci' en rouge
  #utiliser police Equipage Solidaire




