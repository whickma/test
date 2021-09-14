# TIDYVERSE LECTURE
library(tidyverse)

mpg %>%
  filter(manufacturer=="audi") %>%
  group_by(model) %>%
  summarise(hwy_mean=mean(hwy))

packageVersion('dplyr')

starwars %>%
  filter(
    species == "Human",
    height >= 190
  )

starwars %>%
  filter(is.na(height))

starwars %>%
  filter(!is.na(height))

starwars %>%
  filter(is.na(height))

starwars %>%
  arrange(desc(birth_year))

starwars %>%
  arrange(name)

starwars %>%
  select(name:skin_color, species, -height)

starwars %>%
  rename(alias=name, crib=homeworld, sex=gender)

starwars %>%
  select(name, birth_year) %>%
  mutate(dog_years=birth_year*7) %>%
  mutate(comment=paste0(name, " is ", dog_years, " in dog years."))

starwars %>%
  select(name, height) %>%
  mutate(
    tall1=height>180,
    tall2=ifelse(height>180,1,0)
  )

starwars %>%
  slice(c(1,5))

starwars %>%
  filter(gender=="female") %>%
  pull(height)

starwars %>%
  count(species)

starwars %>%
  distinct(species)

starwars %>%
  group_by(species) %>%
  mutate(num=n())

library(nycflights13)
flights
planes

left_join(flights, planes) %>%
  select(year,month,day,dep_time,arr_time,carrier,flight,tailnum,type,model)

left_join(
  flights,
  planes %>% rename(year_built=year),
  by="tailnum"
) %>%
  select(year, month, day, dep_time, arr_time, carrier, flight, tailnum, year_built, type, model) %>%
  head(3)

stocks = data.frame( ## Could use "tibble" instead of "data.frame" if you prefer
  time = as.Date('2009-01-01') + 0:1,
  X = rnorm(2, 0, 1),
  Y = rnorm(2, 0, 2),
  Z = rnorm(2, 0, 4)
)
stocks

tidy_stocks<-
stocks %>%
  pivot_longer(-time, names_to="stock",values_to="price")
