# This file contains a function which returns the summary
# table.
library(dplyr)

rm(list = ls())

# reads the csv file and converts to a dataframe
cali_hs_sat_zip_df <- read.csv("../final deliverable files/data/cali_hs_sat_zip.csv",
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

