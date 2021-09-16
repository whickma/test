library(RSelenium)

#open Firefox
rD <- rsDriver(browser="firefox", port=4545L, verbose=F)
remDr <- rD[["client"]]


