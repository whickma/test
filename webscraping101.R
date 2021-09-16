library(rvest)
library(stringr)
library(lubridate)
library(tidyverse)
library(tidytext)

# #THIS SECTION WORKS FOR THE AEA WEBSITE:
# rm(aea,aeatitles)
# aea<-read_html("https://www.aeaweb.org/journals/search-results?ArticleSearch%5Bwithin%5D%5Barticletitle%5D=1&ArticleSearch%5Bwithin%5D%5Barticleabstract%5D=1&ArticleSearch%5Bwithin%5D%5Bauthorlast%5D=1&JelClass%5Bvalue%5D=0&journal=1&from=a&ArticleSearch%5Bq%5D=")
# aeatitles=
#   aea%>%
#   html_elements(".article .title , .published-at , .author")
# 
# aeatitles<-html_text(aeatitles)
# aeatitles<-as.data.frame(aeatitles)

#WORKS TO GET URL'S FOR ALL PAGES
rm(aermult)
aermult <- c("https://www.aeaweb.org/journals/search-results?id=aer&ArticleSearch%5Bwithin%5D%5Barticletitle%5D=1&ArticleSearch%5Bwithin%5D%5Barticleabstract%5D=1&ArticleSearch%5Bwithin%5D%5Bauthorlast%5D=1&ArticleSearch%5Bq%5D=&JelClass%5Bvalue%5D=0&journal=1&page=") %>%
  paste0(1:234)
  #paste0(c("&page="))
  
aermult     

#WORKS FOR GETTING INFO FROM ALL AER PAGES - scratch that. Only got the first few observations a ton of times
library(pander)
library(stringr)
library(dplyr)

scrape_aer <- function(url) {
  tibble(
    urlsearcher = 
      url %>%
      read_html() %>% 
      html_elements(".article .title , .published-at , .author") %>%
      html_text() 
  )
}

aertitledata<-
aermult[1:234] %>% 
  map_dfr(scrape_aer, .id = "Title") 

aertitle<-aertitledata$urlsearcher

aertitlecopy<-aertitledata

write.table(aertitlecopy,"aertitlecopy.txt",sep="\t",row.names=FALSE, col.names=FALSE,quote=FALSE)

#get rid of the Title column
aertitlecopy<-select(aertitlecopy, -Title)

#drop rows with FRONT MATTER in them DOES NOT WORK

dropfrontmattertest<-headaertitle[headaertitle != "*Front Matter*"]

#make the list of titles, authors, and dates into a data frame
aertitledf<-as.data.frame(aertitlecopy, row.names = NULL, optional = FALSE,
              cut.names = FALSE, col.names = names(x), fix.empty.names = TRUE,
              stringsAsFactors = FALSE)

#default.stringsAsFactors() ADD THIS INSTEAD OF FALSE if it doesn't work
# get rid of leading/trailing white space
aertitletrim<-
aertitledf %>% 
  mutate(across(where(is.character), str_trim))

write.csv(aertitletrim,"aertitletrim.csv")

# convert dates NOT WORKING RIGHT NOW
# library(data.table)
# 
# 
# headaertitlechar<-as.data.frame(headaertitle, row.names = NULL, optional = FALSE,
#                           cut.names = FALSE, col.names = names(x), fix.empty.names = TRUE,
#                           stringsAsFactors = FALSE)
# 
# dates = as.Date(headaertitlechar, format = '%b %Y')  ## Try to coerce to date of form "Jan 01"
# idates = which(!is.na(dates))                ## Get index of all the valid dates (i.e. non-NA)





jstortest<-read_html("https://www.jstor.org/stable/e26562909?refreqid=fastly-default%3A7cf7aa758a28e05a1efa79451422a5b5")
jstortestplus=
  jstortest%>%
  html_elements(".ot-close-icon" , ".inline")
  



m100<-read_html("https://en.wikipedia.org/wiki/Men%27s_100_metres_world_record_progression")
m100

pre_iaaf=
  m100 %>%
  html_element("div+ .wikitable :nth-child(1)") %>%
  html_table()



library(janitor)
library(lubridate)

pre_iaaf=
  pre_iaaf %>%
  clean_names()%>%
  mutate(date=mdy(date))

table2=
  m100 %>%
  html_element("h3+ .wikitable :nth-child(1)") %>%
  html_table()

table2=
  table2%>%
  clean_names()%>%
  mutate(date=mdy(date))



table3=
  m100 %>%
  html_element(".wikitable:nth-child(20) :nth-child(1)") %>%
  html_table()

table3=
  table3%>%
  clean_names()%>%
  mutate(date=mdy(date))

pre_sorted <- pre_iaaf[-c(2:4)]
sortedtwo <- table2[-c(2:6,8)]  
sortedthree<-table3[-c(2:6,8:9)]

combined<-rbind(pre_sorted,sortedtwo,sortedthree)

library(ggplot2)
ggplot(data=combined, aes(x=date, y=time)) +
  geom_point()

base_url = "https://eugene.craigslist.org/search/sss?query=speakers&sort=rel&srchType=T"
craiglist = read_html(base_url)

speakers=
  craiglist%>%
  html_elements(".result-date , .result-hood , .hdrlnk , .result-price")
speakers=html_text(speakers)
head(speakers,20)

aer<-read_html("https://scholar.google.com/scholar?hl=en&as_sdt=0%2C47&q=american+economic+review&btnG=&oq=american+")
aerpdf=
  aer%>%
  html_elements(".gs_or_cit+ a , .gs_a , .gs_ctg2")

aerpdf=html_text(aerpdf)
head(aerpdf,10)

econsearch<-read_html("https://scholar.google.com/scholar?hl=en&as_sdt=0%2C47&q=economics&btnG=")
econpdf=
  econsearch%>%
  html_elements(".gs_or_cit+ a , .gs_a , .gs_ctg2")

econpdf=html_text(econpdf)
head(econpdf,30)

