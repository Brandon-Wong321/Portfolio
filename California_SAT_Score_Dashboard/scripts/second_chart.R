# This file contains the function for the second visualisation. 

library(dplyr)
library(ggplot2)
library(plotly)

rm(list = ls())

# reads in the csv files and converts into a dataframe
data <- cali_hs_sat_zip_df <- read.csv("../final deliverable files/data/cali_hs_sat_zip.csv",
  stringsAsFactors
  = FALSE
)

# A function that returns a chart
chart_2 <- function(data) {
  chart <- ggplot(data = data) +
    geom_col(mapping = aes(
      x = TotalSatScore, y = MedianHouseholdIncome,
      fill = Zip
    ), position = "dodge") +
    ggtitle("SAT Score vs ZIP Code Income by HS") +
    xlab("HS Average SAT Score") +
    ylab("Zip Code Median Income")
  return(ggplotly(chart))
}
chart_two <- chart_2(data)

