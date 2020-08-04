library(tidyverse)
library(httr)
library(jsonlite)

template <- read.csv('csvjson.csv')
countyData <- read.csv('countyData.csv')
countyPops <- read.csv('countyPopulations.csv')

states <- c("Alabama",
            "Alaska",
            "Arizona",
            "Arkansas",
            "California",
            "Colorado",
            "Connecticut",
            "Delaware",
            "Florida",
            "Georgia",
            "Hawaii",
            "Idaho",
            "Illinois",
            "Indiana",
            "Iowa",
            "Kansas",
            "Kentucky",
            "Louisiana",
            "Maine",
            "Maryland",
            "Massachusetts",
            "Michigan",
            "Minnesota",
            "Mississippi",
            "Missouri",
            "Montana",
            "Nebraska",
            "Nevada",
            "New Hampshire",
            "New Jersey",
            "New Mexico",
            "New York",
            "North Carolina",
            "North Dakota",
            "Ohio",
            "Oklahoma",
            "Oregon",
            "Pennsylvania",
            "Rhode Island",
            "South Carolina",
            "South Dakota",
            "Tennessee",
            "Texas",
            "Utah",
            "Vermont",
            "Virginia",
            "Washington",
            "West Virginia",
            "Wisconsin",
            "Wyoming")


countyPops <- countyPops %>% 
  filter(!(CTYNAME %in% states))

countyData <- countyData %>% 
  select(fips, date, countyName, stateName, cumulativeInfected)

countyData2 <- countyData %>% 
  filter(fips < 10000) %>% 
  mutate(fips = paste0("0", fips))

countyData3 <- countyData %>% 
  filter(!(fips < 10000)) %>% 
  mutate(fips = as.character(fips))

countyDataMerged <- rbind(countyData2, countyData3)

countyDataWithPop <- countyDataMerged %>% 
  mutate(Population = filter(countyPops, CTYNAME == countyName)[[2]])

