#' ---
#' title: "Plot DE Mobility Change in COVID-19 Period"
#' output: github_document
#' ---

#+ message=FALSE
xfun::pkg_attach2("rio", "tidyverse")
theme_set(theme_minimal())

mobility <- import("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv")


#' ## Attempt 1
#' 
#' This attempt produces a nonsensical plot.
 
# Subset 
de_mobility <- subset(mobility, country_region_code == "DE")

de_mobility_sub <- select(de_mobility, country_region_code,
                          date,
                          retail_and_recreation_percent_change_from_baseline,
                          transit_stations_percent_change_from_baseline)

# Pivot longer
de_mobility_long <- pivot_longer(de_mobility_sub,
                                 cols = c(3, 4),
                                 names_to = "destination",
                                 values_to = "change_in_mobility")

# Convert date to date class object
de_mobility_long$date <- as.Date(de_mobility_long$date)

# Plot
ggplot(de_mobility_long, aes(x = date, y = change_in_mobility,
                             group = destination,
                             linetype = destination)) +
  geom_line()

