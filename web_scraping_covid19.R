#load necessary packages
library(dplyr)
library(rvest)
library(stringr)

#load table from worldometer
table_worldometer <- "https://www.worldometers.info/coronavirus/" %>%
  read_html() %>%
  html_nodes("table") %>%
  html_table(fill=T)

#selecting the first element from table_worldometer 
covid_world <- as.data.frame(table_worldometer[[1]])

#changing name of country variables
colnames(covid_world)[1] <- "Country.pos"
colnames(covid_world)[2] <- "Country"

#excluding special characters
covid_world$TotalCases <- as.numeric(gsub(",", "", covid_world$TotalCases))
covid_world$NewCases <- as.numeric(gsub("[+,]", "", covid_world$NewCases))
covid_world$NewDeaths <- as.numeric(gsub("[+,]", "", covid_world$NewDeaths))
covid_world$NewRecovered <- as.numeric(gsub("[+,]", "", covid_world$NewRecovered))
covid_world$TotalDeaths <- as.numeric(gsub(",", "", covid_world$TotalDeaths))
covid_world$TotalRecovered <- as.numeric(gsub(",", "", covid_world$TotalRecovered))

#removing regional and global aggregate data
covid_world <- covid_world %>% filter(!is.na(Country.pos))

#Total Covid-19 deaths
sum(covid_world$TotalDeaths, na.rm=T)
#Total Covid-19 cases
sum(covid_world$TotalCases, na.rm = T)
