library(jsonlite)

yelp_business_info <- read.csv(file("/Users/williamhickman/citations/yelp_business_clean.csv"))

str(yelp_business_info)

yelp_business_info %>%
arrange(stars)

library(sf)
points<-st_as_sf(yelp_business_info, coords=c("longitude", "latitude"), crs=4326)
plot(st_geometry(points), pch=16, col="navy")

library(OpenStreetMap)
