#twitter ness
#libraries
library(twitteR)
library(RCurl)
library(bitops)
library(RJSONIO)
	setwd("C:\\Documents and Settings\\Ty\\My Documents\\twitter test")
#step 1
	lotus.tweets = searchTwitter('@grouplotusplc', n=5000)
#step 2
	length(lotus.tweets)
	class(lotus.tweets)
	tweet = lotus.tweets[[1]]
	class(tweet)
	tweet$getScreenName()
	tweet$getText()
#Extracting text
	lotus.text = lapply(lotus.tweets, function(t) t$getText() )
	length(lotus.text)
	head(lotus.text, 5)
	class(lotus.text)
#issue with scoring, It won't read the lexicon file... you have to read that from 
#the website, they haven't made a package for it yet



#load file
	opin<-read.csv("C:\\Documents and Settings\\Ty\\My Documents\\twitter test\\opinion lexicon.csv")

#scoring
hu.liu.pos = opin$positive.words
hu.liu.neg = opin$negative.words
pos.words = hu.liu.pos
neg.words = hu.liu.neg
#sentiment scoring algorithm
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
	require(plyr)
	require(stringr)
 
	# we got a vector of sentences. plyr will handle a list
	# or a vector as an "l" for us
	# we want a simple array of scores back, so we use 
	# "l" + "a" + "ply" = "laply":
	scores = laply(sentences, function(sentence, pos.words, neg.words) {
 
		# clean up sentences with R's regex-driven global substitute, gsub():
		sentence = gsub('[[:punct:]]', '', sentence)
		sentence = gsub('[[:cntrl:]]', '', sentence)
		sentence = gsub('\\d+', '', sentence)
		# and convert to lower case:
		sentence = tolower(sentence)
 
		# split into words. str_split is in the stringr package
		word.list = str_split(sentence, '\\s+')
		# sometimes a list() is one level of hierarchy too much
		words = unlist(word.list)
 
		# compare our words to the dictionaries of positive & negative terms
		pos.matches = match(words, pos.words)
		neg.matches = match(words, neg.words)
 
		# match() returns the position of the matched term or NA
		# we just want a TRUE/FALSE:
		pos.matches = !is.na(pos.matches)
		neg.matches = !is.na(neg.matches)
 
		# and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
		score = sum(pos.matches) - sum(neg.matches)
 
		return(score)
	}, pos.words, neg.words, .progress=.progress )
 
	scores.df = data.frame(score=scores, text=sentences)
	return(scores.df)
}

lotus.scores = score.sentiment(lotus.text, pos.words,
								neg.words, .progress='text')
lotus.scores$airline = 'lotus'
hist(lotus.scores$score)



#check 
