# TOPIC2

# Law of Large Numbers
# Statement:
# Suppose there is a sequence of numbers, Xn, come from some distribution with 
# mean mu.
# Then the theorem says that as n goes to infinity (sufficiently large),
# we expect that the sample average (or sample mean) converges to mu
# asymptotically. 

# A Single Experiment
n = 1000
x = rbinom(n, 1, 0.5) # suppose data come from Bernoulli distribution (which is Binomial with k = 1)
mean(x)

# Simulation: Many Experiments
n = seq(0, 1e4, 1e2)[-1]; n
xList = matrix(0L, 1, length(n))
for (i in 1:length(n)) {
  x = rbinom(n[i], 1, 0.5)
  xList[i] = mean(x)
  plot(n, xList, type = "b");
  abline(h = 0.5, col = "red")
} # Done

# Library
library(animation)

## Plot Monte Carlo Simulation of Coin Toss
saveGIF({
  # Simulation
  n = seq(0, 1e4, 1e2)[-1]; n
  xList = matrix(NA, 1, length(n))
  for (i in 1:length(n)) {
    x = rbinom(n[i], 1, 0.5)
    xList[i] = mean(x)
    plot(n, xList, type = "b",
         xaxs = "i",
         main = paste0("Simulation of Coin Toss; \nApprox =  ", round(mean(x), 3)));
    abline(h = 0.5, col = "red")
  } # Done
}, movie.name = "C:/Users/eagle/OneDrive/PalmDrive/Classrooms/StatsProgram/2021Winter/Scripts/mc-sim-cointoss.gif", interval = 0.8, nmax = 30, ani.width = 480)


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
