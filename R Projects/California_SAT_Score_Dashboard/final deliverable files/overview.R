# text for purpose of the project
overview_purpose <- "These days, more universities decided to waive SAT
          requirements in their undergraduate admission process.
          As UW students, most of us have experience taking the SAT or
          the ACT at some point in our lives, thus choosing this topic.
          It is interesting to see this transition happening and we hope
          we can find a way to explain such transitions with data collected
          across different demographic/socioeconomic groups. As colleges and
          universities place a high level of value on standardized tests,
          often people of lower socioeconomic groups are unable to access
          resources that others are able to, such as SAT prep courses.
          We hope to show you that standardized tests may contribute to
          social inequality as they can more often represent one's
          socioeconomic status more so than their educational aptitude."

# links saved into variables for hyperlinks
income_url <- "http://www.usa.com/rank/california-state--median-household-income--zip-code-rank.htm"

r1_link <- "https://www.racecounts.org/"
r2_link <- "http://californiadatacollaborative.org/"
r3_link <- "https://www.lacountyartsedcollective.org/models-resources/resources/california-arts-education-data-project"

# function that structures the page
overview_gen <- function(content) {
  if (content == "purpose") {
    return(
      div(
        h1("Purpose of Our Project"),
        p(overview_purpose),
        img(src =
              "https://vpandey26.files.wordpress.com/2019/03/n-college-acceptance-628x314.jpg?w=640")
      )
    )
  } else if (content == "data") {
    return(
      div(
        h1("Source of data"),
        p(
          "The Data is from the ",
          a(
            "California Department of Education",
            href = "https://www.cde.ca.gov/ds/sp/ai/"
          ),
          " as well as the ",
          a("American Community Survey from 2010 - 2014",
            href = income_url
          ), "."
        ),
        img(src = "https://www.connectva.org/wp-content/uploads/2014/10/uuidf5c0f158-233b-427c-9f3a-769ddb11123bgroupId10157t14121755898705.jpeg")
      )
    )
  } else if (content == "research") {
    return(
      div(
        h1("Other Relavent Research"),
        tags$ol(
          tags$li(
            p(
              a(
                "Race Counts",
                href = r1_link
              ),
              ": Race Counts measures the overall performance,
              amount of racial disparity, and impact by population
              size of counties and cities in California."
            )
          ),
          tags$li(
            p(
              a(
                "California Arts Education Data Project",
                href = r3_link
              ),
              ": The Data Project is designed to increase participation
              in arts education across the state by analyzing and reporting
              school-level data on arts education courses and grades 6
              through 12 enrollment."
            )
          ),
          tags$li(
            p(
              a(
                "California Data Collaborative",
                href = r2_link
              ),
              ": Their analytics help water managers plan for and achieve
              their new water efficiency goals. CaDC tools make use of agency
              and external data to assist staff with tasks like understanding
              water efficiency in their service area, analyzing the water
              savings of water efficiency rebates, and forecasting the impact
              of water rate changes."
            )
          )
        ),
        img(src = "https://i.ibb.co/sg7pysb/collage.png")
      )
    )
  }
}
