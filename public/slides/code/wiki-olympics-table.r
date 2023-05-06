#################
# Scrape BBC Sochi Olympics Medals Table
# Christopher Gandrud
# 6 June 2021
#################

# Load packages
xfun::pkg_attach2("rvest", "dplyr", "purrr", "janitor")

# URL with the medals table
URL <- 'https://en.wikipedia.org/wiki/2012_Summer_Olympics_medal_table'

#### Gather content and parse the table, note there is only one table ####
medals_table <- URL %>% read_html() %>%
                html_nodes('table') %>%
                html_table() %>% 
                pluck(3) %>% # Extract the third table using pluck from purrr
                as.data.frame

medals_table <- clean_names(medals_table)

head(medals_table)

# Sort by total medals in descending order
medals_table <- arrange(medals_table, desc(total))

head(medals_table)

# Filter out "Totals" row
medals_table <- medals_table %>%
  filter(total < 900) %>%
  arrange(desc(total))

head(medals_table)
