library("tidyverse")
library("rvest")
library("tidytext")
library("SnowballC")
library("wordcloud2")

# get list via https://www.xml-sitemaps.com/
ma <- c("jenny-bennett", 
        "dr-dietrich-engels", 
        "ferzaneh-fakdani", 
        "stefan-feldens", 
        "dr-michael-fertig", 
        "dr-philipp-fuchs", 
        "katrin-hunger", 
        "lisa-huppertz", 
        "georg-kalvelage", 
        "dr-regine-koeller", 
        "kunze", 
        "christian-loschelder", 
        "vanita-matta", 
        "christine-maur", 
        "uta-micic", 
        "franziska-porwol", 
        "marco-puxi", 
        "eva-roth", 
        "friedrich-scheller", 
        "alina-schmitz", 
        "anne-marie-scholz", 
        "katja-seidel", 
        "hans-verbeek", 
        "juergen-viedenz", 
        "wellmer")

# url parameters
base_url <- "https://www.isg-institut.de/autor/"

# scrap profiles  
data <- lapply(ma, function(person) {
  url <- paste0(base_url, person)
  
  html <- read_html(url, verbose = TRUE)
  
  core <- html %>%
    html_nodes(".ma-text p") %>% 
    html_text()
})

# create dataframe
text <- tibble(profil = unlist(data))

# list of stopwords
stopwords_de <- enframe(stopwords::stopwords("de"), name = NULL, value = "words")

# tokenize / remove stopwords and numbers 
token <- text %>%
  filter(profil != "") %>%
  filter(!str_detect(profil, "^[Wir trauern]+")) %>%
  unnest_tokens(input = profil, output = words, to_lower = FALSE) %>%
  filter(str_detect(words, "[A-Z]+")) %>%
  mutate(lower = str_to_lower(words, locale = "de")) %>%
  anti_join(stopwords_de, by = c("lower" = "words"))

# aggregrate words / filter freqs
wordcounts <- token %>%
  count(words) %>%
  arrange(desc(n)) %>%
  filter(words != "Seit") %>% # quick fix
  filter(n > 2)

# generate wordcloud
wordcloud2(wordcounts, shuffle = FALSE, color = "blue") 

