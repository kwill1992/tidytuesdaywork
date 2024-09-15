#tidytuesday
#2023-11-07
#Author: Kevin Williams
#Company: RRL Data Analytics, LLC
#US House Election Results
#Located here: https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-07/readme.md

# Some sources used for this:
# https://www.geeksforgeeks.org/how-to-create-state-and-county-maps-easily-in-r/
# https://cran.r-project.org/web/packages/usmap/vignettes/mapping.html
# https://www.littlemissdata.com/blog/usmap
# https://urban-institute.medium.com/how-to-create-state-and-county-maps-easily-in-r-577d29300bb2
# https://jtr13.github.io/cc19/different-ways-of-plotting-u-s-map-in-r.html



#get data
#Option 1: tidytuesdayR package
library(tidyverse)
library(tidytuesdayR)
tuesdata <- tidytuesdayR::tt_load('2023-11-07')
# this is a list
# make into just tibble
tuesdata_df <- tuesdata[1]
tuesdata_df <- tuesdata_df$house

#Option 2: read directly from GitHub
library(tidyverse)
house <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-07/house.csv')

#Option 3: download data, save to folder, open with readr
#Download here: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/IG0UN2
library(tidyverse)
houseData <- read_csv('~/Documents/r-studio-and-git/tidytuesdaywork/2023-11-07 _US_House_Election_Results/dataverse_files/1976-2022-house.csv')



#Data Exploration
house

#quick view of data
head(house)

#summary of dataset
summary(house)

# get congressional district data
library(tigris)
library(leaflet)
cd116 <- congressional_districts(cb = TRUE, resolution = '20m')

leaflet(cd116) %>%
  addTiles() %>%
  addPolygons()


01        ALABAMA
02        ALASKA
04        ARIZONA
05        ARKANSAS
06        CALIFORNIA

# steps
# parse data to one year
house <- house %>% filter(year == "1976")
house
summary(house)

# if party == "NA" or other than Republican or Democrat, then make "Independent"
# get file again
house <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-07/house.csv')
# get unigue values of party
unique(house$party)
# there are a lot!
# create new column which has Democrat, Republican, or Independent
house <- house %>% mutate(party_clean = case_when(party == "DEMOCRAT" ~ "Dem",
                                                  party == "REPUBLICAN" ~ "Rep",
                                                  TRUE ~ "Ind"))
# check unigue values for just Dem, Rep, Ind
unique(house$party_clean)

# help for above
# https://www.statology.org/dplyr-mutate-multiple-conditions/
# https://statisticsglobe.com/replace-values-in-data-frame-conditionally-in-r#example-2-conditionally-exchange-values-in-character-variable
# https://www.statology.org/r-unique-values-in-column/
# https://rdrr.io/cran/tidyr/man/replace_na.html  
# https://sparkbyexamples.com/r-programming/replace-using-dplyr-package-in-r/
  
  
# NEXT NEXT NEXT
# get winner for each district

# use tigris and cd116 for district?
# what if district changes by year?
# maybe do a slide to have beginning vs ending districts


#make an interactive plotly or shiny by year
#two types: stacked bar with dems/reps/indie by year
# and slider to move year by state with state map

# make a map with house by Dem and Rep



#bar chart view