library(readxl)
# load data
aerurls <- read_excel("/Users/williamhickman/Desktop/aerurlsFINAL.xlsx")

library(tidyverse)

# get rid of spaces and replace with +
aerurls<-
  aerurls%>%
  mutate(url2=str_replace_all(url2," ","+"))

# put everything into one unified url
aerurls$complete <- paste(aerurls$url1,aerurls$url2,aerurls$url3)

# cut it down to only include the column with the whole url
aerurls <- aerurls$complete

# make the testurls vector into a data frame
aerurls<-as.data.frame(aerurls)

#make sure there aren't any spaces, replace these with nothing 
aerurls<-
  aerurls%>%
  mutate(aerurls=str_replace_all(aerurls," ",""))


# # export to a text file
write.table(aerurls,"aerurlsFINALVERSIONFORREALwithquotes.txt",sep="\t",row.names=FALSE, col.names=FALSE,quote=FALSE)
