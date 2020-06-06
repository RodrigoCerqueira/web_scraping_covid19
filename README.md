# web_scraping_covid19
> R code to web scraping Covid-19 data from worldometers.info.

This code do a web scraping from Worldometer Coronavirus page. 
Worldometers.info is responsible for all the data.
_go to [https://www.worldometers.info/coronavirus/](https://www.worldometers.info/coronavirus/) to more information._

# Packages
Load the necessary packages
```sh
library(dplyr)
library(rvest)
```
# Running
Loading the worldometers.info/coronavirus tables
```sh
table_worldometer <- "https://www.worldometers.info/coronavirus/" %>%
  read_html() %>%
  html_nodes("table") %>%
  html_table(fill=T)
  ```
Selecting the correct table
  ```sh
  covid_world <- as.data.frame(table_worldometer[[1]])
  ```
Changing variable names
  ```sh
colnames(covid_world)[1] <- "Country.pos"
colnames(covid_world)[2] <- "Country"
```
Removing special characters
```sh
covid_world$TotalCases <- as.numeric(gsub(",", "", covid_world$TotalCases))
covid_world$NewCases <- as.numeric(gsub("[+,]", "", covid_world$NewCases))
covid_world$NewDeaths <- as.numeric(gsub("[+,]", "", covid_world$NewDeaths))
covid_world$NewRecovered <- as.numeric(gsub("[+,]", "", covid_world$NewRecovered))
covid_world$TotalDeaths <- as.numeric(gsub(",", "", covid_world$TotalDeaths))
covid_world$TotalRecovered <- as.numeric(gsub(",", "", covid_world$TotalRecovered))
```
Removing regional and global data
```sh
covid_world <- covid_world %>% filter(!is.na(Country.pos))
```
Showing total deaths and total cases
```sh
#Total Covid-19 deaths
sum(covid_world$TotalDeaths, na.rm=T)
#Total Covid-19 cases
sum(covid_world$TotalCases, na.rm = T)
```
