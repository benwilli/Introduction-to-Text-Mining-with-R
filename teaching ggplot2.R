#load in the tidyverse package
library(tidyverse)

#look at the example data
str(mpg)

#use qplot()
qplot(displ,cty,data=mpg)
qplot(displ,hwy,data=mpg,facets = .~drv)

#use ggplot
mpg %>% ggplot(aes(x=manufacturer,y="",fill=model)) #what happens in this line?
mpg %>% ggplot(aes(x=manufacturer,y="",fill=model)) + geom_col() #add a layer!

#make it cooler
mpg %>% ggplot(aes(x=manufacturer,y="")) + geom_col(aes(fill=cty))

#add a title
mpg %>% ggplot(aes(x=manufacturer,y="")) + geom_col(aes(fill=cty)) + labs(main="first ggplot!")

#different geom
mpg %>% ggplot(aes(x=displ,y=hwy)) + geom_point() 

#faceting
mpg %>% ggplot(aes(x=displ,y=hwy)) + geom_point() + facet_grid(.~drv)

#label the x-axis
mpg %>% ggplot(aes(x=displ,y=hwy,shape=manufacturer)) + geom_point() + facet_grid(.~drv) + xlab("DIPLAY")
