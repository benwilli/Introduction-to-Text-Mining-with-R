install.packages(tidytext)
install.packages(tidyverse)
library(tidytext)
library(tidyverse)

#what is the structure of our example data
str(mpg)

#base R
plot(displ~hwy,data=mpg)

#using functin from package ggplot2, which was loaded into R by package tidyverse
qplot(displ,hwy,data=mpg)
