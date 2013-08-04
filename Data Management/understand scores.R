#understand scores

	library(sqldf)
	all<-sqldf("select *, count(score) as total from 'all.scores' group by
			airline,score")

	m1<-sqldf("select *, avg(score) as mean, stdev(score) as sigma
			from 'all.scores' group by airline")
	m2<-sqldf("select* from m1 order by mean")
	m3<-sqldf("select *, count(score) as total from 'all.scores' group by
			airline")

	neat<-sqldf("select * from m2 join m3 using (airline)")

	neater<-sqldf("select airline,mean,sigma,total from neat order by total")