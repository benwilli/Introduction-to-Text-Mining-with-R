#here we are going to load all of hansard into R

library(data.table)
library(tidyr)
library(dplyr)

#set your working directory wherever the data is at
setwd("C:/Users/32443181/Box Sync/hansard-tsvs")

#read in all of hansard, which is saved as a tsv
#this takes 1 minute 8 seconds on my machine but may take a little longer
stemmed.tsv.1.f<-fread("stemmed_debates.tsv",header=FALSE,sep="\t")

#what is the structure?
str(stemmed.tsv.1.f)

#####################################
#  currently, stemmed_debates.tsv has columns: YEAR, DECADE, TITLE, TEXT
#  need to Change to be ID, LABEL, TEXT
#  Year + Title = ID 
#  Decade = LABEL
#  Text = TEXT
#####################################

#combine columns 1 and 3 into a new column
# the new column is still titled column 1, and we remove column 3
stemmed.tsv.2<-unite(stemmed.tsv.1.f,V1,V1,V3,remove=TRUE)

#look at the new structure
str(stemmed.tsv.2)

#let's rename column 4 to be called column 3
stemmed.tsv.2.b<-rename(stemmed.tsv.2,V3=V4)

#check out the structure again
str(stemmed.tsv.2.b)
#stemmed.tsv.2.b now has columns "YEAR+Title","Decade", "Text"

#now let's save this file for future use, like in Mallet
write.table(stemmed.tsv.2.b,file="C:/Users/32443181/Box Sync/hansard-tsvs/stemmed_debates_b.tsv",sep="\t",col.names = FALSE,row.names = FALSE)

# test the table to make sure it looks right
stemmed.tsv.3.test <- fread("stemmed_debates_b.tsv",header=FALSE,sep="\t")

#check out the structure
str(stemmed.tsv.3.test)
