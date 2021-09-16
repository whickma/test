#making a list of URL's (article titles are from Excel)
library(readxl)

# load data
testurls <- read_xl("~/Desktop/Fall 2021/testurls.xlsx")

library(tidyverse)

# get rid of spaces and replace with +
testurls<-
  testurls%>%
    mutate(url2=str_replace_all(url2," ","+"))

# put everything into one unified url
testurls$complete <- paste(testurls$url1,testurls$url2,testurls$url3)

# cut it down to only include the column with the whole url
testurls <- testurls$complete
 
# make the testurls vector into a data frame
testurls<-as.data.frame(testurls)

#make sure there aren't any spaces, replace these with nothing 
testurls<-
  testurls%>%
  mutate(testurls=str_replace_all(testurls," ",""))
  

# # export to a text file
write.table(testurls,"testurlsanothertry.txt",sep="\t",row.names=FALSE, col.names=FALSE,quote=FALSE)
 
#class(testurls)
#testurls[,colnames(testurls)=="complete"]
