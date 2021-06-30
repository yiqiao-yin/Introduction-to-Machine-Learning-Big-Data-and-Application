#### Data ####

# Library: quantmod
library(quantmod)
getSymbols("ARKK")
dim(ARKK)
head(ARKK, 2) # the first 6 rows for the data frame
tail(ARKK, 10) # the bottom 6 rows for the data frame
summary(ARKK)
chartSeries(
  ARKK[1500:1676, ], # [1400th row up to 1676th row, all columns]
  theme = chartTheme("black"),
  name = "SOME STOCK: ARKK",
  TA = c(
    addEMA(12, col = 'green'),
    addEMA(26, col = 'cyan'),
    addEMA(50, col = 'yellow')
  ))

# Question: what is EMA?
# clean your memory
# rm(list=ls()) # potential error here!
dta = seq(1, 100, 1) # create fake data
data = data.frame(dta, lag(dta)) # I have lag(), this means I am shifting data back m spot
data = data[-1, ]
# Computation of EMA
n = 12 # this is the number of days you want to compute K
K = 2/(n+1) # K is a scaling factor that decrease exponentially as you increase n
ema_example = K*data$dta + (1-K)*data$lag.dta. # formula for computing EMA
data$EMA = ema_example
head(data)
matplot(data)

# Interactive Plot
# install.packages("dygraphs")
newData = ARKK[, 1:4]
library(dygraphs)
# %>% symbol works as a connection to build upon a 
# previously define objects using the package dygraphs
dygraph(newData) %>% dyCandlestick() %>%
  dyLegend(show = "onmouseover", hideOnMouseOut = TRUE) %>%
  dyRangeSelector()

# Data
head(ARKK)
summary(ARKK$ARKK.Close)
plot(ARKK$ARKK.Close)
quantmod::dailyReturn(ARKK$ARKK.Close)
plot(quantmod::dailyReturn(ARKK$ARKK.Close))
ARKK_return = quantmod::dailyReturn(ARKK$ARKK.Close) # this is the reality and it's the truth I need (benchmark)
par(mfrow=c(1,2))
hist(ARKK_return, breaks = 30)
# mean(ARKK_return) # mean() <= sample average
# sd(ARKK_return) # sd() <= standard deviation sd()^2 this is variance
# hist(rnorm(length(ARKK_return), 0, 0.02))
hist(rnorm(length(ARKK_return), mean(ARKK_return), sd(ARKK_return)))

# Monte Carlo Tree Search (MCTS) <= this is about 60% of AlphaGo concept
# Definition:
# We learned about Monte Carlo Simulation (aka Monte Carlo Markov Chain)
# Now, we want to update our MCMC with paramters computed from real data
# this action finishes up ONE GENERATION of MCTS
# A standard MCTS can have many generations (the exact number 
# is a tuning parameter and depends on the experiment)

# This is my code for one generation:
# xxx + 1L <= returns + 1 and it is used for taking integration
# matrix() <= this is like a data frame but mostly for numerical entries (all if possible)
# apply(X: whatever data you want to apply function on, 
#       MARGIN: which direction row = 1, col = 2, 
#       FUN: whatever function without parenthesis you want to apply here)
# X = matrix(rnorm(250*10, 0, 0.001) + 1L, nrow = 250, ncol = 10)
# cumprod(c(1,2,3,4)) # cumulative product
# cumX = apply(X, 2, cumprod)
# par(mfrow=c(1,1))
# matplot(cumX, type = "l")
# X = matrix(rnorm(num_of_days*path, expected_return, expected_sd) + 1L, ncol = path); X[1, ] <- 1L
# cum_X <- apply(X, 2, cumprod)
pack = YinsCapital::MCMC_Simulation(
  seed = 1,
  path = 100,
  expected_return = 0.005,
  expected_sd = 0.02,
  num_of_days = 250,
  type = "l" )
head(pack$Cumu_Return_Matrix) # simulated data
ARKK_return # target
# Next:
# figure out which path is the most accurate one
# function to keep in mind is which()
# and error function (I'll define later)

# Monte Carlo Tree Search
# Start 1 GEN: 
d = 1 # change later, but for now it tracks the index of generation
mu = 0 # mean
s = 0.005 # SD
num.of.sim = 10
num.of.days = 25
data = matrix(rnorm(num.of.sim*num.of.days, mean = mu, sd = s), nrow = num.of.days)
data[1,] = 0L # enforce the first to be 0
for (N in seq(10, num.of.days, 10)) {
  select.data = data[1:N, ]
  cumret = select.data + 1L
  cumretpath = apply(cumret, 2, cumprod)
  plot(
    x = 1:N, 
    y = cumretpath[,1],
    main = paste0("Simulated Path for $1 ", "\nMean = ", mu, "SD = ", s),
    type = "l",
    col = 1,
    xlim = c(1, num.of.days), # the length of plot on x coordinate I want disregard how long the data is
    ylim = c(min(cumretpath), max(cumretpath)) )
  for (i in 2:num.of.sim) {lines(x = 1:N, y = cumretpath[, i], type = "l", col = i)}
} # Done

# Tree Search Current Gen for the candidate with the Least Errors 
# we want the candidate with the least mistakes!!!!!
ARKK_return = quantmod::dailyReturn(ARKK$ARKK.Close) # this is entire data I have
k = 1
ARKK_return_temp = ARKK_return[k:(k+num.of.days-1)] # this is the segment of the data that I am allowed to use to make a comparison
ARKK_return_temp = ARKK_return[1:20, ]
length(ARKK_return_temp)

# Comparison
# error function / loss function <= the standard that my machine refers to
# when I want to tell my machine what is right or wrong (i.e. recall that this is refering to a scale, a spectrum)
# loss function: mean square error (MSE) / root mean square error (RMSE)
# MSE = sum((vector 1 - vector 2)^2)/n
# RMSE = sqrt(sum((vector 1 - vector 2)^2)/n)
dim(select.data) # 20 days by 10 paths
j = 1 # the index j is set to 1
select.data[, j] # this refers to the jth column
mean((ARKK_return_temp - select.data[, j])^2)
vectorMistakes = sapply(1:10, function(j) {mean((ARKK_return_temp - select.data[, j])^2)}) # this is the mistakes made for each colum
leastError = min(sapply(1:10, function(j) {mean((ARKK_return_temp - select.data[, j])^2)}))
bestIdx = which(vectorMistakes == leastError) # it produces the index of the candidate that makes the least mistakes
bestIdx

# Summary
# This experiment generates certain amount of path. Some path
# goes up and some goes down. Most of them stay in the middle.
# I want the candidate (path) that moves the closest as the 
# actual path of the stock ARKK (which I can download data
# and I know how it moves)
# <= this is MCTS (with one generation)

# Remark
# cumprod() is a function that computes the cumulative product
# cumret: this is an object I defined it's a matrix with all entries 
# added 1 (1L is used because it's for all entries in a matrix)

#### MCTS ####

# Library
library(animation)

# Data
tickers = "AAPL"
quantmod::getSymbols(tickers)
closePrices <- do.call(merge, lapply(tickers, function(x) get(x)[,4])) # this defines the closing price
closeReturns <- quantmod::dailyReturn(closePrices)
simulatedReturns = closeReturns
correctPath = cumprod(closeReturns + 1)
par(mfrow=c(1,2))
plot(correctPath, main = paste0("Entered Ticker: ", tickers, " (starting from $1)"))
L = length(closeReturns)
plot(closePrices, main = paste0("Entered Ticker: ", tickers, " (daily closing price)"))

# Define data
mu = 0 # my assumption
s = 0.005 # my assumption
num.of.sim <- 3e3
num.of.days <- 25
data <- matrix(rnorm(num.of.sim*num.of.days,mean=mu,sd=s),nrow=num.of.days); data[1, ] = 0L
updatedPath <- data
takeBearIntoConsideration = FALSE # this means we ignore the switch of considering the possibility of a bear market


# Create GIF
setwd("C:/Users/eagle/OneDrive/Desktop/")
saveGIF({
  for (d in 1:length(c(seq(1, L-num.of.days, num.of.days)[-length(seq(1, L-num.of.days, num.of.days))], L - num.of.days))) {
    # Setup
    currGenIdx = d
    d = seq(1, L, num.of.days)[d]
    
    # Start New Generation of MC Simulation
    par(mfrow=c(2, 1))
    if (d > 1) {
      # THIS IS IMPORTANT!!!!
      # mu and s are my choice (no scientific reason, purely guesses)
      # I need to fact check myself every end of the generation
      # and I need to update these beliefs according to the best
      # candidate we have
      
      
      mu = mean(data[, currIdx]) # every generation, I update my parameters used for creating new data <= update mean
      s = sd(data[, currIdx]) # every generation, I update my parameters used for creating new data <= update SD
      
      
      
      
      
    } # update parameter of prior distribution
    if (takeBearIntoConsideration) {
      data1 <- matrix(rnorm((.5*num.of.sim)*num.of.days,mean=mu,sd=s),nrow=num.of.days); data1[1, ] = 0L
      data2 <- matrix(rnorm((.5*num.of.sim)*num.of.days,mean=mu,sd=s)*(-1),nrow=num.of.days); data2[1, ] = 0L
      data <- cbind(data1, data2)
    } else {
      data <- matrix(rnorm(num.of.sim*num.of.days,mean=mu,sd=s),nrow=num.of.days); data[1, ] = 0L
    }
    for (N in seq(10,num.of.days,10)) {
      select.data <- data[1:N, ]
      cumret <- select.data + 1L
      cumretpath <- apply(cbind(cumret), 2, cumprod)
      # plot(x = 1:N, y = cumretpath[,1], type = "l", 
      #      main = paste0(
      #        "Simulated Path for $1 Investment\n Comment: X1, X2, ..., X", num.of.sim, 
      #        " drawn from N(",mu,",",s,") assuming iid"),
      #      ylab = "Numbers in USD",
      #      xlab = paste0("Time from Day 1 to Day ", N), 
      #      xaxs = "i", yaxs = "i",
      #      col = 1, xlim = c(1, num.of.days), ylim = c(min(cumretpath), max(cumretpath)))
      # for (i in 1:num.of.sim) { lines(x = 1:N, y = cumretpath[, i], type = "l", col = i) }
    } # end of current generation
    
    # Tree Search Current Generation for Least Errors
    # which(sth == sth)
    # cheat: which.max(c(5,2,3))
    currIdx = which.min(
      apply(
        cumretpath, 2,
        function(c) {
          # c is a dummary variable (name by choice)
          # Mean Square Error
          # c <= is referring to the column in fake data <= an educated guess
          # cumprod(closeReturns + 1)[1:num.of.days] <= is referring to the reality (truth)
          # mean((vector1 - vector2)^2) <= the formula for this error function called MSE
          mean((c - cumprod(closeReturns + 1)[1:num.of.days])^2)
        } 
      )
    )
    currMSE = mean((cumretpath[, currIdx] - cumprod(closeReturns + 1)[1:num.of.days])^2)
    
    # Store
    closeReturns[1:num.of.days]
    simulatedReturns[d:(d+num.of.days-1)] = data[, currIdx]
    
    # Visualization
    plot(x = 1:(d+num.of.days), y = correctPath[1:(d+num.of.days)],
         main = paste0("Real Path for Ticker: ", tickers, " (starting from $1)"),
         type = "l",
         ylab = "Numbers in USD",
         xlab = paste0("Time from Day 1 to Day ", d+num.of.days), 
         xaxs = "i", yaxs = "i",
         col = 1, xlim = c(1, L))
    simulatedPath = cumprod(simulatedReturns + 1)
    plot(x = 1:(d+num.of.days), y = simulatedPath[1:(d+num.of.days)],
         main = paste0(
           "Simulated Path Up to ", currGenIdx, "th Gen (starting from $1)\nRMSE for Current Gen is ", round(sqrt(currMSE), 4)),
         type = "l",
         ylab = "Numbers in USD",
         xlab = paste0("Time from Day 1 to Day ", d+num.of.days), 
         xaxs = "i", yaxs = "i",
         col = 1, xlim = c(1, L))
    
    # Checkpoint
    print(paste0("Finished ", currGenIdx, "/", length(seq(1, L, num.of.days))))
  } # end of all generations
}, movie.name = "mc-sim-random-walk-adv.gif", interval = .5, nmax = 30,
ani.width = 800, ani.height = 600)




# apply family functions avoid for loops (speed things up)
matrixA = matrix(1:9, nrow = 3, ncol = 3)
apply(matrixA, 1, function(dummyvariable) print(c('hey', dummyvariable)))
apply(matrixA, 2, function(dummyvariable) print(c('hey', dummyvariable)))
matrixA
apply(matrixA, 2, function(dum) c(1L - dum^2)) # assuming matrix, so 2D
sapply(1:10, function(dum) 1L-sqrt(dum^3+6))
c(1:10)^3
