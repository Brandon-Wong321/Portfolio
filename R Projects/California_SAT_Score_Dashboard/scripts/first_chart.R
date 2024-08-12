# This file contains a function for chart one.

library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("lintr")

rm(list = ls())

# This function cleans up the raw data and returns a map.
map_gen <- function() {
  ca_sat19 <- read.csv("../final deliverable files/data/ca-sat19.csv", stringsAsFactors = F)
  ca_income <- read.csv("../final deliverable files/data/ca-county_income.csv", stringsAsFactors = F)
  ca_school <- read.csv("../final deliverable files/data/ca-pubschls.csv", stringsAsFactors = F)

  ca_coord <- select(ca_school, Latitude, Longitude, County) %>%
    group_by(County) %>%
    summarise(
      lat = mean(as.numeric(Latitude), na.rm = T),
      lng = mean(as.numeric(Longitude), na.rm = T)
    )

  ca_income["NameClean"] <- gsub(" County, CA", "", ca_income$Name)
  ca_income["NameClean"] <- gsub(" County/city, CA", "", ca_income$NameClean)

  ca_sat19_county <- dplyr::group_by(ca_sat19, CName) %>%
    filter(RType == "C")
  ca_income_sat <- left_join(ca_income, ca_sat19_county,
    by = c("NameClean" = "CName")
  )
  ca_income_sat <- transform(ca_income_sat,
    NumERWBenchmark12 = as.numeric(NumERWBenchmark12)
  )
  ca_income_sat <- filter(ca_income_sat, !is.na(NumERWBenchmark12)) %>%
    filter(NumTSTTakr12 > 50)
  ca_income_sat <- mutate(ca_income_sat,
    "PctERWBenchmark12" = as.numeric(
      PctERWBenchmark12
    )
  ) %>%
    mutate("PctMathBenchmark12" = as.numeric(PctMathBenchmark12)) %>%
    mutate("PctBothBenchmark12" = as.numeric(PctBothBenchmark12))
  ca_income_sat_long <- pivot_longer(
    ca_income_sat,
    c(
      "PctERWBenchmark12",
      "PctMathBenchmark12"
    ),
    "type"
  )
  ca_income_sat_loc <- left_join(
    ca_income_sat,
    ca_coord, c("NameClean" = "County")
  )
  pal <- colorNumeric(
    palette = c("white", "navy"),
    domain = ca_income_sat_loc$PctBothBenchmark12
  )
  map <- leaflet(ca_income_sat_loc) %>% addTiles()
  map %>%
    addCircleMarkers(
      lng = ~lng, lat = ~lat, color = ~ pal(PctBothBenchmark12),
      fillOpacity = 1,
      popup = ~ paste0(
        NameClean, " County", "<br>",
        PctBothBenchmark12,
        "% of 12th grade student passed benchmark."
      )
    )
}
chart_one <- map_gen()
