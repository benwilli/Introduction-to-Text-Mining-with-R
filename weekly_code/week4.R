#install/load required packages
install.packages("janeaustenr")
library(janeaustenr)
library(dplyr)
install.packages("stringr")
library(stringr)
library(tidytext)
library(ggplot2)
install.packages("gutenbergr")
library(gutenbergr)
library(tidyr)
install.packages(scales)
library(scales)

#the works of Jane Austen
original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%  ungroup()
#what is the structure of original_books
str(original_books)

#look at it
original_books

#tidy the works of Jane Austen
tidy_books <- original_books %>%
  unnest_tokens(word, text)

#look at it
tidy_books

#remove stop words from tidy_books
tidy_books <- tidy_books %>%
  anti_join(stop_words)

#look at the word count
tidy_books %>%
  count(word, sort = TRUE)

#plot the word counts
tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

#get hgwells data
hgwells <- gutenberg_download(c(35, 36, 5230, 159))

#tidy the hgwells data
tidy_hgwells <- hgwells %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

#look at the word count
tidy_hgwells %>%
  count(word, sort = TRUE)

#get the Bronte data
bronte <- gutenberg_download(c(1260, 768, 969, 9182, 767))

#tidy the Bronte data
tidy_bronte <- bronte %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

#look at the word count
tidy_bronte %>%
  count(word, sort = TRUE)

#look at frequency for each word for the works of Jane Austen, the Brontë sisters, and H.G. Wells
frequency <- bind_rows(mutate(tidy_bronte, author = "Brontë Sisters"),
                       mutate(tidy_hgwells, author = "H.G. Wells"),
                       mutate(tidy_books, author = "Jane Austen")) %>%
  mutate(word = str_extract(word, "[a-z']+")) %>%
  count(author, word) %>%
  group_by(author) %>%
  mutate(proportion = n / sum(n)) %>%
  select(-n) %>%
  spread(author, proportion) %>%
  gather(author, proportion, `Brontë Sisters`:`H.G. Wells`)

#structure of frequency tibble
str(frequency)

#expect a warning about rows with missing values being removed
ggplot(frequency, aes(x = proportion, y = `Jane Austen`, color = abs(`Jane Austen` - proportion))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "gray75") +
  facet_wrap(~author, ncol = 2) +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = NULL)
