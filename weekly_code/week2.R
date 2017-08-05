install.packages(tidytext)
install.packages(tidyverse)
library(tidytext)
library(tidyverse)

#what is the structure of our example data
str(mpg)

#look at the first few rows of the dataframe
head(mpg)

#look at the last few rows of the dataframe
tail(mpg)

#look at the variable "manufacturer"
mpg$manufacturer

#look at the variable "hwy"
mpg$hwy

#summarize the variable "hwy"
summary(mpg$hwy)

#base R plot
plot(displ~hwy,data=mpg)

#using functin from package ggplot2, which was loaded into R by package tidyverse
qplot(displ,hwy,data=mpg)
