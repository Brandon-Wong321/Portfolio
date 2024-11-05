library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
library(DT)

# source files for all pages
source("intro_page.R")
source("summary_takeaway_page.R")
source("interactive_page_3.R")
source("interactive_page_2.R")
source("summary_table_page.R")
source("overview.R")

# first page sidepanel
page_one_sidepanel <- sidebarPanel(
  h2("Contents"),
  selectInput(
    "p1_content",
    "Choose from the following options:",
    choices = list(
      "Purpose of Our Project" = "purpose",
      "Data Sources" = "data",
      "Relavent Research" = "research"
    ),
  ),
  img(
    src = "https://www.fccnn.com/incoming/4676816-7wuexj-SAT/alternates/BASE_LANDSCAPE/SAT",
    width = "70vw"
  ),
  img(
    src = "https://sierranewsonline.com/wp-content/uploads/2018/01/California-Department-of-Education-e1516666248141.png",
    width = "70vw"
  )
)

# first page mainpanel
page_one_mainpanel <- mainPanel(
  uiOutput("overview")
)

# first page
page_one <- tabPanel(
  tags$div(
    id = "test_color",
    "Project Overview"
  ),
  page_one_sidepanel,
  page_one_mainpanel
)

# second page
page_two <- tabPanel(
  tags$div(
    id = "test_color",
    "Summary Table"
  ),
  titlePanel("Table of California Zip Codes, Income, and SAT Scores"),
  h3("Information About the Table:"),
  p("In this tab, we have organized economic data and SAT scores
    from California High Schools and grouped them by Zip Code. You
    can arrange the data or search for a specific Zip Code."),
  dataTableOutput(
    outputId = "summary_table"
  )
)

# third page
page_three <- tabPanel(
  tags$div(
    id = "test_color",
    "Bar Chart"
  ),
  titlePanel("SAT Scores Binned by Income"),
  third_page_sidebar,
  third_page_main
)

# sixth page sidepanel
page_six_sidepanel <- sidebarPanel(
  selectInput(
    "p6_content",
    h2("Contents:"),
    choices = list(
      "Summary Table" = "summary_table",
      "Map" = "first_visualisation",
      "Scatter Plot" = "second_visualisation",
      "Bar Chart" = "third_visualisation"
    )
  )
)

# sixth page mainpanel
page_six_mainpanel <- mainPanel(
  uiOutput("takeaway")
)

# sixth page
page_six <- tabPanel(
  tags$div(
    id = "test_color",
    "Project Takeaways"
  ),
  tags$body(
    id = "sixth_page_background"
  ),
  page_six_sidepanel,
  page_six_mainpanel
)

# ui function used in app.R file
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    h4("Standardized Testing and
       Median Household Income in California"),
    page_one,
    page_two,
    page_map,
    page_three,
    page_four,
    page_six
  )
)
