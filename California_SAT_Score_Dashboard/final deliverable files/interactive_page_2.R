# Creating second page for shiny app

library(plotly)
library(stringr)

# Scatter Plot

plot_scatter <- function(data,
                         search = "",
                         xvar = "TotalSatScore",
                         yvar = "MedianHouseholdIncome") {
  xmax <- max(data[, xvar]) * 1.5
  ymax <- max(data[, yvar]) * 1.5

  data <- data %>%
    filter(grepl(search, Zip))

  p <- plot_ly(
    x = data[, xvar],
    y = data[, yvar],
    mode = "markers",
    marker = list(
      opacity = .4,
      size = 8
    )
  ) %>%
    layout(
      xaxis = list(
        range = c(0, 2400),
        title = "High School SAT Score"
      ),
      yaxis = list(
        range = c(0, ymax),
        title = "Median Household Income (by zip code)"
      )
    )
  return(p)
}

# creates the side panel for the page
scatter_sidebar_content <- sidebarPanel(
  textInput("search", label = h2("Find a Zip code"), value = "")
)

# creates the main panel for the page
scatter_main_content <- mainPanel(
  h3("Questions and Explanation of the Information:"),
  p("The purpose of this visualization is to plot high school
  average SAT scores and median income by zip code. This is to
  visualize any particular trends among specific zip codes."),
  plotlyOutput("scatter"),
  h3("Information about the Plot:"),
  p("By referenecing our summary table, the user is able to
  input the first three digits of any zip code of a high school
  to find trends in specific areas across California.")
)

# creates the page
page_four <- tabPanel(
  tags$div(
    id = "test_color",
    "Scatter Plot"
  ),
  titlePanel("High School SAT Score v.s. Median Household Income"),

  sidebarLayout(
    scatter_sidebar_content,
    scatter_main_content
  )
)
