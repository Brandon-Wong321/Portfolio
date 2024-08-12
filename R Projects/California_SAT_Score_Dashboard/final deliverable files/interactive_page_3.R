# Creating third page for shiny app

library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)

cali_hs_sat_zip_df <- read.csv("data/cali_hs_sat_zip.csv",
  stringsAsFactors
  = FALSE
)

# Making Scatter Plot
build_third_plot <- function(dataframe, input) {
  chart <- ggplot(
    dataframe,
    aes(x = input, y = MedianHouseholdIncome)
  ) +
    geom_point(size = 1, color = "darkblue") +
    geom_smooth(method = lm) +
    ggtitle("SAT Score vs ZIP Code Income by HS") +
    xlab(input) +
    ylab("Zip Code Median Income")
  return(ggplotly(chart))
}

x_axis <- "AvgScrMath"

build_third_plot(cali_hs_sat_zip_df, x_axis)

# Making Binned Bar Graph

binned_income_interactive <- function(dataframe,
                                      bin,
                                      yvar = "AvgTotalSATScore") {
  df <- dataframe %>%
    filter(MedianHouseholdIncome != is.na(MedianHouseholdIncome)) %>%
    mutate(
      income_bin_primary =
        if (min(floor(MedianHouseholdIncome / bin)) == 0) {
          (floor(MedianHouseholdIncome / bin) + 1)
        } else {
          (floor(MedianHouseholdIncome / bin))
        }
    ) %>%
    mutate(
      income_bin =
        ifelse(income_bin_primary > 10,
          10,
          income_bin_primary
        )
    ) %>%
    group_by(income_bin) %>%
    summarize(
      AvgTotalSATScore = mean(TotalSatScore),
      AvgRead = mean(AvgScrRead),
      AvgMath = mean(AvgScrMath),
      AvgWrite = mean(AvgScrWrite)
    )

  if (yvar == "AvgTotalSATScore") {
    y_lim <- 2400
    title <- "SAT Score: Total by Income Bin"
    y_title <- "Total SAT Score"
  } else {
    y_lim <- 800
    title <- paste(
      "SAT Score:",
      substr(yvar, 4, nchar(yvar)),
      "by Income Bin"
    )
    y_title <- paste(
      substr(yvar, 4, nchar(yvar)),
      "SAT Score"
    )
  }

  plot <- plot_ly(df,
    x = df$income_bin,
    y = df[[yvar]],
    type = "bar",
    hoverinfo = "text",
    text = ~paste0("</br> Income Group: $", (df$income_bin - 1) * bin,
                  " - $", df$income_bin * bin,
                  "</br> Avg Score:", round(df[[yvar]]))
  ) %>%
    layout(
      title = title,
      xaxis = list(
        title = "Income Bin",
        zeroline = FALSE
      ),
      yaxis = list(
        title = y_title,
        zeroline = FALSE,
        range = c(0, y_lim)
      )
    )

  return(plot)
}

binned_income_interactive(cali_hs_sat_zip_df, 25000, yvar = "AvgTotalSATScore")

binned_income_summary <- function(dataframe, bin, yvar = "AvgTotalSATScore") {
  df <- dataframe %>%
    filter(MedianHouseholdIncome != is.na(MedianHouseholdIncome)) %>%
    mutate(
      income_bin_primary =
        if (min(floor(MedianHouseholdIncome / bin)) == 0) {
          (floor(MedianHouseholdIncome / bin) + 1)
        } else {
          (floor(MedianHouseholdIncome / bin))
        }
    ) %>%
    mutate(
      income_bin =
        ifelse(income_bin_primary > 10,
          10,
          income_bin_primary
        )
    ) %>%
    group_by(income_bin) %>%
    summarize(
      AvgTotalSATScore = mean(TotalSatScore),
      AvgRead = mean(AvgScrRead),
      AvgMath = mean(AvgScrMath),
      AvgWrite = mean(AvgScrWrite)
    )

  max_bin <- df %>%
    filter(income_bin == max(income_bin)) %>%
    pull(income_bin)

  max_bin_amount <- (max_bin - 1) * bin

  max_bin_score <- df %>%
    filter(income_bin == max(income_bin)) %>%
    pull(yvar)

  min_bin_score <- df %>%
    filter(income_bin == min(income_bin)) %>%
    pull(yvar)

  message1 <- paste0(
    "Income Bin 1 is Zip Codes with Median
                   Household Income (MHI) under $",
    bin,
    ". Bin 2 is between $",
    bin,
    " and $",
    round(2 * bin),
    " and so forth. Income Bin ",
    max_bin,
    " is Zip Codes with MHI
                   above $",
    max_bin_amount,
    "."
  )
  message2 <- paste0(
    "The test score difference
    between Income Bin 1 and
    Income Bin ",
    max_bin,
    " is ",
    round(max_bin_score - min_bin_score),
    "."
  )

  message <- paste(message1, "\n", message2)

  return(message)
}

#information about the visualisation
explanation <- "In the below graph, we attempt to answer how the average test
    score differs when we group high schools by their area's
     Median Household Income. We also are trying to visualize any trends
    between the different portions of the exam."

sidebar_info <- "In this panel, choose which portion of the test
    you would like to measure, or if you would like to
    show the total score of the SAT. You can also group
    Zip Codes by Income, based on the bin number above."

third_page_sidebar <- sidebarPanel(
  selectInput("y_var_bar",
    label = h2("SAT Score Breakdown"),
    choices = list(
      "Total" = "AvgTotalSATScore",
      "Reading" = "AvgRead",
      "Writing" = "AvgWrite",
      "Math" = "AvgMath"
    )
  ),
  numericInput("income_bin_var",
    label = h2("Income Bin Breakdown"),
    value = 25000,
    min = 10000,
    max = 100000,
    step = 5000
  ),
  p(sidebar_info)
)

options(scipen = 999)

third_page_main <- mainPanel(
  includeCSS("style.css"),
  h3("Questions and Explanation of the Information:"),
  p(explanation),
  plotlyOutput(
    outputId = "income_bar"
  ),
  h3("Information about the Graph:"),
  uiOutput("income_bin_summary"),
)
