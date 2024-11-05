#Project - Midpoint Deliverable, Data Exploration
library("dplyr")
rm(list = ls())

#Getting the datasets
cali_sat <- read.csv("final deliverable files/data/ca-sat15.csv",
                     stringsAsFactors = FALSE)

cali_school_info <- read.csv("final deliverable files/data/ca-pubschls.csv",
                             stringsAsFactors = FALSE)

cali_county_income <- read.csv("final deliverable files/data/ca-county_income.csv",
                               stringsAsFactors = FALSE)

cali_zip <- read.csv("final deliverable files/data/ca-zip-mhi.csv",
                     stringsAsFactors = FALSE)
# Source is http://www.usa.com/rank/california-state--median-household-income--zip-code-rank.htm
# Data aggregated from ACS 2010 - 2014 ACS Data

#Matching Zip Codes to School Name
cali_school_zip <- cali_school_info %>%
  select(School, Zip)

cali_sat_zip <- left_join(cali_sat,
                          cali_school_zip,
                          by = c("sname" = "School"))

#Processing SAT Score File
cali_sat_zip$Zip <- substr(cali_sat_zip$Zip, 1, 5)

cali_hs_satScores <- cali_sat_zip %>%
  filter(rtype == "S") %>%
  select(sname, AvgScrRead, AvgScrMath, AvgScrWrite, Zip) %>%
  distinct(sname, .keep_all = TRUE) %>%
  group_by(sname) %>%
  mutate(TotalSatScore = sum(as.numeric(AvgScrRead),
                             as.numeric(AvgScrWrite),
                             as.numeric(AvgScrMath))) %>%
  filter(TotalSatScore != is.na(TotalSatScore))

cali_hs_satScores$Zip <- as.integer(cali_hs_satScores$Zip)

#Combining County Income and SAT Scores
nchar(" County, CA")

cali_county_sat <- cali_sat_zip %>%
  filter(rtype == "C") %>%
  select(cname, AvgScrRead, AvgScrMath, AvgScrWrite) %>%
  mutate(TotalSatScore = as.numeric(AvgScrRead) +
           as.numeric(AvgScrWrite) +
           as.numeric(AvgScrMath)) %>%
  filter(TotalSatScore != is.na(TotalSatScore))

cali_county_income <- cali_county_income %>%
  mutate(cname = substr(Name, 1, nchar(Name) - nchar(" County, CA")))

cali_county_sat_income <- cali_county_sat %>%
  left_join(cali_county_income) %>%
  select(cname, AvgScrRead, AvgScrMath, AvgScrWrite,
         TotalSatScore, MIH)

#Combining California and ZIP Code MHI
cali_hs_sat_zip <- cali_hs_satScores %>%
  left_join(cali_zip)

names(cali_hs_sat_zip)[7] <- "MedianHouseholdIncome"
write.csv(cali_hs_sat_zip, file = "cali_hs_sat_zip.csv")
