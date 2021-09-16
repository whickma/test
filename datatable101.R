library(jsonlite)

nyc_trees<-
  fromJSON("https://data.cityofnewyork.us/resource/uvpi-gqnh.json")%>%
  as_tibble()
nyc_trees

nyc_trees %>%
  select(longitude, latitude, stump_diam, spc_common, spc_latin, tree_id) %>%
  mutate_at(vars(longitude:stump_diam),as.numeric)%>%
  ggplot(aes(x=longitude,y=latitude,size=stump_diam))+
  geom_point(alpha=0.5)+
  scale_size_continuous(name = "Stump diameter") +
  labs(
    x = "Longitude", y = "Latitude",
    title = "Sample of New York City trees",
    caption = "Source: NYC Open Data"
  )

endpoint = "series/observations"
params = list(
  api_key= "055611a9cbd8955f1e0e80b7865af145", ## Change to your own key
  file_type="json", 
  series_id="GNPCA"
)

library(httr)

fred = 
  httr::GET(
    url = "https://api.stlouisfed.org/", ## Base URL
    path = paste0("fred/", endpoint),    ## The API endpoint
    query = params                       ## Our parameter list
  )

fred <-
  fred %>%
  httr::content("text")%>%
  jsonlite::fromJSON()

typeof(fred)

fred <-
  fred %>%
  purrr::pluck("observations")%>%
  as_tibble()
fred

library(lubridate)
fred<-
  fred%>%
  mutate(across(realtime_start:date,ymd))%>%
  mutate(value=as.numeric(value))

fred%>%
  ggplot(aes(date,value))+
  geom_line(col="blue")+
  scale_y_continuous(labels=scales::comma)+
  labs(
    x="Date",
    y="2012 USD (billions)",
    title="U.S. Real Gross National Product",
    caption="Source: FRED"
  )
