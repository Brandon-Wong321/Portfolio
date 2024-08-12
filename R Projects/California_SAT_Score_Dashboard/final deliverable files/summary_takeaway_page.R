# this file contains the function which structures the takeaway page

takeaway_gen <- function(content) {
  if (content == "summary_table") {
    return(
      div(
        h1("Takeaways from Summary Table:"),
        tags$ul(
          tags$li(
            p(
              "From the summary table, we
              can clearly observe that zip
              codes in the beginning (low SAT
              scores) of the list are the areas
              with low average household income."
            )
          ),
          tags$li(
            p(
              "The zip codes towards the end of
              the list (high SAT scores) are the areas
              with high average household incomes and
              higher SAT scores."
            )
          ),
          tags$li(
            p(
              "From the abovementioned takeaways, we
              can infer that the household income impacts
              the overall SAT score for students. Moreover
              the ZIP codes starting with 94(Los Angeles
              Area) were the areas with higher average SAT
              score.The Los Angeles area is particularly
              famous for celebrities and hollywood.
              The presence of these people impacts the average
              household income for that area, ultimatley
              impacting the average SAT score. Whereas,
              the areas with ZIP codes starting with
              93(King County) are less populated areas
              with small local businesses. Hence, the
              average income is low leading to low
              average SAT scores."
            )
          )
        ),
        img(src = "https://i.ibb.co/DMvcgp6/
            Screenshot-2020-06-05-at-12-27-47-PM.png")
      )
    )
  } else if (content == "first_visualisation") {
    return(
      div(
        h1("Takeaways from the Map:"),
        tags$ul(
          tags$li(
            p(
              "From the map visualization, we can
              see the average test performance of students
              near San Francisco and Sacramento performes
              better in the California area. In addition
              students near Fresno and southern California
              seems to relatively underperform."
            )
          ),
          img(src = "https://i.ibb.co/xfGkSt1/Screenshot
            -2020-06-04-at-8-48-21-PM.png",
              style="width: 60vw"),
          tags$li(
            p(
              "I suspect this might be explanined in the
              area's average income as well as their 
              population. Counties such as Colusa and Inyo
              had a relativly low percentage of students 
              passing the benchmark due to their geographical
              location being far from other big cities. Also 
              those cities has low populations comparing to 
              others."
            )
          ),
          img(src = "https://i.ibb.co/RvZ1vLy/colusa.png"),
          img(src = "https://i.ibb.co/PhR3MHc/inyo.png")
        )
      )
    )
  } else if (content == "second_visualisation") {
    return(
      div(
        h1("Takeaways from the Scatterplot"),
        tags$ul(
          tags$li(
            p(
              "From this scatterplot, we observe a
              positive linear relationship between SAT
              scores and median income. Based on the trendline,
              there seemed to be several high schools that
              outperformed their expected SAT score based on
              their zip code median income, as well as
              some underperforming richer high schools."
            )
          ),
          tags$li(
            p(
              "For example in the Los Angelos area zip code (900) the
              school with the highest median income (86.573k) only had
              a score 1221 while the school with the lowest (21.009k)
              had a score of 1129. Another interesting trend is that
              some schools, despite having the same median income,
              had a wide range in SAT scores. In the San Francisco
              area zip code (941) schools with a median income of
              around 121k had a range of scores between 1089 to 1725."
            )
          ),
          tags$li(
            p(
              "When analyzing the Los Angelos area, there is a huge
              disparity between median income. The LA area consists of
              diverse areas ranging from the affluent suburbs of Beverely
              Hills to extreme homelessness on Skid Row. Although
              most of the data confirms that there is a linear
              relationship between Median Income and SAT score, in some
              cases income and resources did not factor into SAT performance.
              This was also confirmed in the San Francisco area when the range
              of scores varied despite having the same Median Income. With
              the the surge in tech companies in the  Bay area the median
              income tended to be higher which could explain the
              disperition of scores. As schools tend to
              have higher median income the scores have a higher variance."
            )
          ),
          img(src = "https://i.ibb.co/Fh2z6N4/
              Screenshot-2020-06-04-at-8-49-36-PM.png")
        )
      )
    )
  } else if (content == "third_visualisation") {
    return(
      div(
        h1("Takeaways from the Bar Chart"),
        tags$ul(
          tags$li(
            p(
              "From the bar chart, we a see a linear trend between income
              bin and Total SAT score that transcends all sections of
              the test."
            )
          ),
          tags$li(
            p(
              "While only a small difference, zip codes in lower income bins
              (ie of lower socio-economic status) tend to perform worse on
              math parts of the exam. As we change between the tests,
              the higher income bins stay relatively the same across all tests,
              but the lower bins perform worse on math."
            )
          ),
          tags$li(
            p(
              "From observing the trends when we group data points by income,
              we can see a positive linear correlation between income and
              performance on the SAT. This is the case on each portion of the
              SAT exam prior to its revision in 2017, with the highest disparity
              in the Math exams. With this knowledge, we can acknowledge that
              SAT scores reflect socioeconomic status. We have seen that scores
              are not only a function of wealth, as noted in the scatter plot
              where there are some areas that outperform expectations based on
              wealth. With these takeaways, we can presume that income has a
              noticeable effect on SAT scores because students from a wealthier
              background can access resources otherwise unavailable to poorer
              students. This can be in the form of being able to afford multiple
              opportunities to take the exam, attending a better funded school,
              or through access to test prep courses.The College Board has
              begun to try to rectify the situation by applying an Adversity
              Score to reflect their socioeconomic status."
            )
          )
        ),
        img(src = "https://i.ibb.co/s6KB9cS/
            Screenshot-2020-06-04-at-5-43-27-PM.png")
      )
    )
  }
}
