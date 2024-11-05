# Project Brainstorm

## Domain of  Interest
* Why are you interested in this field/domain?

  These days, more universities decided to waive SAT requirements in their undergraduate admission process. As UW students, most of us have experience taking the SAT or the ACT at some point in our lives, thus choosing this topic. It is interesting to see this transition happening and it would be awesome if we can find a way to explain such transitions with data collected across different demographic/socioeconomic groups.

* What other examples of data driven project have you found related to this domain (share at least 3)?

  1. [Race Counts](https://www.racecounts.org/): Race Counts measures the overall performance, amount of racial disparity, and impact by population size of counties and cities in California.
  2. [California Data Collaborative](http://californiadatacollaborative.org/
    ): Their analytics help water managers plan for and achieve their new water efficiency goals. CaDC tools make use of agency and external data to assist staff with tasks like understanding water efficiency in their service area, analyzing the water savings of water efficiency rebates, and forecasting the impact of water rate changes.
  3. [California Arts Education Data Project](https://www.lacountyartsedcollective.org/models-resources/resources/california-arts-education-data-project): The Data  Project is designed to increase participation in arts education across the state by analyzing and reporting school-level data on arts education courses and grades 6 through 12 enrollment.

* What data-driven questions do you hope to answer about this domain (share at least 3)?

  * Question: How does household income in different areas of California can impact standardized test scores?
    >Answer: Visualization using scatter plots with income data on one axis and test scores on the other.
  * Question: Do geographic factors affect standardized test scores?
    >Answer: Map visualization with different areas colored differently based on respective average SAT scores.
  * Question: Do these socioeconomic factors impact one test more than others?
    >Answer: Aggregate score data vs. income data across multiple time periods with visualization techniques such as waterfall plot.



## Finding Data
* Where did you download the data (e.g., a web URL)?

  The Data is from the [California Department of Education](https://www.cde.ca.gov/ds/sp/ai/) as well as the [IRS website](https://www.irs.gov/statistics/soi-tax-stats-individual-income-tax-statistics-2017-zip-code-data-soi).

* How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?

  The College Board, the creators and managers of the SAT, send student data  to the California Department of Education. After that, they aggregate the data using the school name, school district, and county to produce the state’s SAT Report. The CDE does the same process with the ACT inc to aggregate student-level data for the ACT. The IRS aggregates data based on tax returns of the year that they collect, organized by zip codes.

* How many observations (rows) are in your data?

  * For our data set on California ACT scores in 2019, there are 2,310 observations.
  * For SAT scores, there are 2,580 observations and 25 features.  
  * For our 2017 IRS data set, there are 166,538 observations.

* How many features (columns) are in the data?

  * For our data set on California ACT scores in 2019, there are 17 features.
  * For SAT scores, there are 25 features.  
  * For our 2017 IRS data set, there are 154 features.

* What questions (from above) can be answered using the data in this dataset?

  Currently, we can group student SAT and ACT averages based on the city they’re from. This could potentially tell us which cities had the highest or lowest test scores and compare this with income averages in the IRS data set. We can also be able to visualize how scores have changed over time. Something we must consider is the amount of students enrolled in a particular school and its proportion to the density of the population within cities. The SAT and ACT scores data is also at risk of being skewed by outliers that will shift the mean.
