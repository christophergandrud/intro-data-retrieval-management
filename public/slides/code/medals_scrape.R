#################
# Scrape BBC Sochi Olympics Medals Table
# Christopher Gandrud
# 9 March 2016
#################


######################################## No longer works #####################################

# Load packages
library(rvest)
library(dplyr)
library(janitor)

# URL with the medals table
URL <- 'http://www.bbc.com/sport/winter-olympics/2014/medals/countries'

#### Gather content and parse the table, note there is only one table ####
medals_table <- URL %>% read_html() %>%
                html_nodes('table') %>%
                html_table() %>% 
                as.data.frame

medals_table <- clean_names(medals_table)

head(medals_table)

#### Clean ####
# Drop unwanted variables
medals_table <- select(medals_table, country, gold_medals, silver_medals,
                       bronze_medals, total)

# Give new variable names
names(medals_table) <- c('country', 'gold', 'silver', 'bronze', 'total')

# Sort by total medals in descending order
medals_table <- arrange(medals_table, desc(total))

