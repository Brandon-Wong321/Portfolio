# server.R
library(dplyr)
library(plotly)
library(DT)
library(leaflet)

# source files for all the pages
source("Interactive_page_1.R")
source("interactive_page_3.R")
source("interactive_page_2.R")
source("summary_table_page.R")
source("intro_page.R")
source("overview.R")

# read the csv data file
cali_hs_sat_zip_df <- read.csv("data/cali_hs_sat_zip.csv",
  stringsAsFactors
  = FALSE
)

# omit na values
cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

# server function used in app.R file
server <- function(input, output) {
  # Income Bar for Interactive Page 3
  output$income_bar <- renderPlotly(
    return(binned_income_interactive(cali_hs_sat_zip_df,
      input$income_bin_var,
      yvar = input$y_var_bar
    ))
  )

  output$income_bin_summary <- renderUI({
    return(binned_income_summary(cali_hs_sat_zip_df,
      input$income_bin_var,
      yvar = input$y_var_bar
    ))
  })
  # SAT Score scatter for Interactive page 2
  output$scatter <- renderPlotly({
    return(plot_scatter(cali_hs_sat_zip_df, input$search))
  })

  # Summary Table for summary_table page
  output$summary_table <- renderDataTable({
    return(datatable(summary_table))
  })

  # Summary Takeaway Page
  output$takeaway <- renderUI({
    return(takeaway_gen(input$p6_content))
  })

  # Map for interactive Page 1
  output$map_vis <- renderLeaflet({
    return(map_gen(
      input$map_vis_type, input$map_vis_year
    ))
  })

  # Introduction Page
  output$overview <- renderUI({
    return(overview_gen(input$p1_content))
  })
}

