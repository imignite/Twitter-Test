Twitter-Test
============

Which car companies make people on Twitter the happiest?


How it works:

I used the twitter package for R to download a tweet when the user tags a car company. After downloading a maximum 
of 5000 tweets for each car company I borrow a function (slightly modified) which scores +1 for a positive word 
and -1 for a negative word in a tweet.

If the tweet contained a positive and a negative word the score would be 0.  I then averaged those scores for each 
car company and took this as a rough indication of a car company’s brand image on Twitter.

Given the roughness of the measure I’ve been thinking about a couple of ways to get at brand image on Twitter
In a separate figure I’ve simply counted the total number of tweets each car company is tagged. 

This information is important because a Fiat has the highest positive brand image on average but pulls from a 
sample of only about 15 tweets.

Going forward:

If we treat Twitter data like survey data one question is who/why did someone not answer a question (tweet). What
inferences can we draw from those who are not tweeting about car companies?
