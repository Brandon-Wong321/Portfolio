
# This file contains a function for chart one.

library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("lintr")
library("shiny")

# This function cleans up the raw data and returns a map.
map_gen <- function(type, year) {
  data_to_plot <- paste0("Pct", type, "Benchmark", year)
  ca_sat19 <- read.csv("data/ca-sat19.csv",
    stringsAsFactors = F
  )
  ca_income <- read.csv("data/ca-county_income.csv",
    stringsAsFactors = F
  )
  ca_school <- read.csv("data/ca-pubschls.csv",
    stringsAsFactors = F
  )

  ca_coord <- select(
    ca_school,
    Latitude,
    Longitude,
    County
  ) %>%
    group_by(County) %>%
    summarise(
      lat = mean(as.numeric(Latitude), na.rm = T),
      lng = mean(as.numeric(Longitude), na.rm = T)
    )

  ca_income["NameClean"] <- gsub(
    " County, CA", "",
    ca_income$Name
  )
  ca_income["NameClean"] <- gsub(
    " County/city, CA", "",
    ca_income$NameClean
  )

  ca_sat19_county <- dplyr::group_by(ca_sat19, CName) %>%
    filter(RType == "C")
  ca_income_sat <- left_join(ca_income, ca_sat19_county,
    by = c("NameClean" = "CName")
  ) %>%
    rename(vis_data = data_to_plot) %>%
    mutate(vis_data = as.numeric(vis_data)) %>%
    filter(!is.na(vis_data))
  ca_income_sat_loc <- left_join(
    ca_income_sat,
    ca_coord, c("NameClean" = "County")
  )
  pal <- colorNumeric(
    palette = c("white", "steelblue"),
    domain = ca_income_sat_loc$vis_data
  )
  map <- leaflet(ca_income_sat_loc) %>% addTiles()
  map %>%
    addCircleMarkers(
      lng = ~lng, lat = ~lat, color = ~ pal(vis_data),
      fillOpacity = 1,
      popup = ~ paste0(
        NameClean, " County", "<br>",
        vis_data,
        "% of student passed benchmark."
      )
    ) %>%
    addLegend("topright", pal,
      values = ~vis_data,
      title = "",
      labFormat = labelFormat(suffix = "%"),
      opacity = 1
    )
}

page_map <- tabPanel(
  tags$div(
    id = "test_color",
    "Map"
  ),
  titlePanel("Map of Percentage of Students That Passed SAT by Counties"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "map_vis_type",
        h2("Type of test"),
        list(
          "Evidence-Based Reading and Writing" = "ERW",
          "Math" = "Math",
          "Combined" = "Both"
        )
      ),
      radioButtons(
        "map_vis_year",
        h2("Year of student"),
        list(
          "12th Grade" = 12,
          "11th Grade" = 11
        )
      )
    ),
    mainPanel(
      h3("Questions and Explanation of the Information:"),
      p("The purpose of this visualization is to highlight the
        potential relationship between geographical locations
        and the average SAT performace. Using map visualization,
        we can get a better insight on location vs. SAT performance.
        Here is the visualization:"),
      leafletOutput("map_vis"),
      h3("Information about the Map:"),
      p("From the map visualization, we can see there seems to be
      a higher percentage of students passing the performance benchmark
      near San Francisco and Sacramento than other places. Students near
      Fresno seem to have significantly lower performance than others.")
    )
  )
)
