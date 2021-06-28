# CENTRAL LIMIT THEOREM
# you do something, and it looks like a bell-shape curve
library(quantmod) # load library (you need to install it if you don't have it)
getSymbols("AIG") # download a stock ticker: for example, we look at AIG
plot(AIG[, 4]) # let us plot the 4th column of AIG data frame
head(AIG$AIG.Close) # first 6 rows
tail(AIG$AIG.Close) # last 6 rows
stockReturn = quantmod::dailyReturn(AIG) # stock return (daily) of the company AIG
tail(stockReturn)
mean(stockReturn[1:3500]) # sample mean / sample average
sd(stockReturn[1:3500]) # standard deviation ~ square root of variance
