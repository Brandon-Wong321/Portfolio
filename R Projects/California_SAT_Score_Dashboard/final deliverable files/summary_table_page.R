library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
library(DT)


cali_hs_sat_zip_df <- read.csv("data/cali_hs_sat_zip.csv",
  stringsAsFactors
  = FALSE
)

# omits the NA values
cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

# the summary table
summary_table <- cali_hs_sat_zip_df %>%
  select(Zip, MedianHouseholdIncome, TotalSatScore) %>%
  group_by(Zip) %>%
  summarise(
    household_income = mean(MedianHouseholdIncome), overall_sat_score
    = mean(TotalSatScore)
  ) %>%
  arrange(overall_sat_score)

colnames(summary_table) <- c("ZIP Code",
                             "Household Income",
                             "Overall SAT Score")

sum_tb <- function(data) {
  return(datatable(summary_table))
}
