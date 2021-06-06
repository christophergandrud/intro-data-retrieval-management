#################
# Scrape BBC Sochi Olympics Medals Table
# Christopher Gandrud
# 6 June 2021
#################

# Load packages
library(rvest)
library(dplyr)
library(purrr)
library(janitor)

# URL with the medals table
URL <- 'https://en.wikipedia.org/wiki/2012_Summer_Olympics_medal_table'

#### Gather content and parse the table, note there is only one table ####
medals_table <- URL %>% read_html() %>%
                html_nodes('table') %>%
                html_table() %>% 
                pluck(2) %>% # Extract the second table using pluck from purrr
                as.data.frame

medals_table <- clean_names(medals_table)

head(medals_table)

# Sort by total medals in descending order
medals_table <- arrange(medals_table, desc(rank))
