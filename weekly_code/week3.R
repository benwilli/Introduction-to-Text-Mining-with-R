#make a new object, titled "text", which is 4 lines of a poem
text <- c("Because I could not stop for Death -",
          "He kindly stopped for me -",
          "The Carriage held but just Ourselves -",
          "and Immortality")

#print out the poem
text

#install and load the dplyr package
install.packages(dplyr)
library(dplyr)

#turn the poem into a tibble(a type of data frame)
text_df <- data_frame(line = 1:4, text = text)

#print out the data frane
text_df

#load the tidytext package
library(tidytext)

#use the unnest_tokens() function to put the poem into the tidy text format
text_df %>%
  unnest_tokens(word, text)
