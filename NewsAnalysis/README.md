# Overview

News media are important sources of  information on the Covid-19 pandemic as they report safety guidelines, health data, government actions, and the public opinion

Yet, News media sources may cover different topics or change their writing style based on their political affiliation to cater to their audience.

The goal of our project is to discover if news sources truly differ in their reporting for the purpose of furthering their political affiliations’ agenda. The ramifications of this type of reporting is an increased social divide among the public

# Research Questions

1. What do Fox and CNN like to bring up in terms of COVID?

2. Are their writing styles distinct enough that we can train a classification     model to correctly identify where an article is coming from?

3. Is there a statistically significant difference in frequency of certain word usages between the two news sources?

# Workflow

- Web Scraping
- Word Cloud Visualization
- TF-IDF Vectorizer and Random Forest for Classification
- Statistical Analysis of Word Frequency

# Files

- cnn_link2: CNN news articles
- fox_link2: Fox news articles
- news_scrape.py: Web scraping script
- test.py: Tests the web scraping result accuracy
- make_wordcloud.py: Word cloud visualization script
- analysis.py: scripts to reformat the dataset and run the ML model

# Instructions

- To run our program, you need to pip install requests, nltk, bs4, textblob, newspaper3k,newspaper, and wordcloud.

- After these packages, you can run news_scrape.py to build a CSV file that contains scraped content of 66 news articles from CNN and Fox News.

- To reproduce the word cloud, run make_wordcloud.py which will generate png images of two word clouds.

- Run analysis.py to train our machine learning model, view results of model accuracy and our statistical analysis.

Thanks for reading! We hope you like the project!
