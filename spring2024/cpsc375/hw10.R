# HW 10
library(janeaustenr)
library(tidyverse)
library(tidytext)
library(wordcloud)

austen_sense_sensibility <- austen_books() %>% filter(book==("Sense & Sensibility")) %>% select(text)
#austen_sense_sensibility %>% View()

austen_tokens <- austen_sense_sensibility %>% unnest_tokens(input="text", output="word") 
austen_tokens <- austen_tokens %>% anti_join(stop_words)
austen_tokens_over_100 <- austen_tokens %>% count(word) %>% filter(n>100)
austen_tokens_over_100 %>% View()

wordcloud(austen_tokens_over_100$word, austen_tokens_over_100$n)

d1 <- tibble(document=1:3,text = c("all things bright", "all things beautiful", "created all"))
d1 <- d1 %>% unnest_tokens(input="text", output="word") 
d1 <- d1 %>% count(document, word) 
d1 <- d1 %>% bind_tf_idf(word, document, n) 
d1 <- d1 %>% select(word, document, tf_idf)
d1 <- d1 %>% pivot_wider(names_from=document, values_from=tf_idf, values_fill=list(tf_idf = 0))

cossim <- function(vec1, vec2) {
  return (sum(vec1*vec2) / (sqrt(sum(vec1^2)) * sqrt(sum(vec2^2))))
}

test_1 <- c(1,2,3)
test_2 <- c(0,2,5)

cossim(test_1,test_2)

cossim(d1$`1`, d1$`2`)
cossim(d1$`1`, d1$`3`)
cossim(d1$`2`, d1$`3`)


library(SnowballC)
austen_novels <- austen_books() %>% unnest_tokens(input="text", output="word") %>% anti_join(stop_words) %>% mutate(word=wordStem(word)) %>% count(book, word,name="freq") %>% filter(freq>5) %>% bind_tf_idf(word, book, freq) %>% select(word, book, tf_idf) %>% pivot_wider(names_from=book, values_from=tf_idf, values_fill = list(tf_idf=0))


similarity_score_df <- data.frame()

for (i in 2:(ncol(austen_novels) - 1)) {
  for (j in (i+1):ncol(austen_novels)) {
    similarity_score <- cossim(austen_novels[i], austen_novels[j])
    novel_comparison_name <- paste(names(austen_novels)[i], '&', names(austen_novels)[j])
    similarity_score_df <- rbind(similarity_score_df, data.frame(Novels_Compared=novel_comparison_name, Similarity=similarity_score))
  }
}

View(similarity_score_df)
