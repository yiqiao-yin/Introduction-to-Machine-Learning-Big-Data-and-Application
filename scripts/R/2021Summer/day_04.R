#### Brownian Motion ####

#########################################################

# Lab
install.packages("animation")
library(animation) # package that you need
ani.options(interval = 0.05, nmax = 150)
brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow", main = "Demonstration of Brownian Motion")
# rnorm()

# How to code this?
# 

> brownian.motion
function (n = 10, xlim = c(-20, 20), ylim = c(-20, 20)) 
{
  x = rnorm(n) # n means number of sample points
  y = rnorm(n) # n means number of sample points
  for (i in 1:100) {
    # dev.hold()
    plot(x, y, xlim = xlim, ylim = ylim)
    text(x, y)
    x = x + rnorm(n)
    y = y + rnorm(n)
    # ani.pause()
  }
}

# One question: (take-home)
# Can I keep track of each of them?
# You can also start with one person to be "RED" color (this means he is affected with some disease)
# If he gets into certain (definition of your choice) range of the "RED" dot
# he is affected and will carry "RED" color for the rest of the animation.
# He will affect others if others get close to him as well. 
# Stop animation if all dots are "RED". 
# A simulation of COVID19 spread. 

#################### BIG PICTURE #############################

# Math: we can derive models ex: bernoulli, ex: normal distribution
#       we can derive expectation (1st moment), variance (1st moment, and 2nd moment),
#       higher moments 
# Simulation: Brownian Motion
#       1. randomly generated dots, using normal distribution
#       2. create animation to allow us to see how the dots move (*)
# Real World Application
#       1. get stock data, i.e. getSymbols() function in quantmod library
#       2. compute returns 
# quantmod::dailyReturn()
# quantmod::weeklyReturn()
# quantmod::monthlyReturn()
#       3. create animation (**)
# Research question:
# what is the difference between results of (*) and (**)?????
# Answer: 
#       1. theoretical answer: you shouldn't be able to tell the difference
#          => random walk (book: Random Walk Down Wall Street)
#       2. real answer: it depends (you need to look at other factors: bias in the data, data collection process, news, political risk, .....)

# Bonus:
# Based on your understanding of answer 1. 
# you can start interpreting this trading strategy:
# the momentum strategy!!!!

#################### BROWNIAN MOTION #######################

## Plot brownian motion
saveGIF({
  brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
}, movie.name = "brownian_motion.gif", interval = 0.1, nmax = 30, 
ani.width = 600)

################# WEEK/MONTH RETURNS BROWNIAN MOTION STYLE ##################


# Define a function that calculates returns
All.Indice.3D.Enter <- function(
  a,b,c,d, e,f,g,h
) {
  # Data # collecting all stock data in a list
  # python equivalent: dictionary{stock1(it's a data frame), stock2, ...... stock8}
  data.list <- list( a,b,c,d, e,f,g,h )
  # placeholder: call it all
  all <- matrix(NA, nrow = 8, ncol = 4) 
  # 8 <= number of stocks entered
  # 4 <= this is because I want to do 4 things later
  
  # Update Momentum:
  for (i in c(1:nrow(all))){
    # assume a is defined as AAPL
    # if i = 1
    # then data.list[i=1] is the dataframe of AAPL
    data.list = list(AAPL)
    all[i,1] <- (
      3272, 4
      data.frame(data.list[i])[3272, 4] # this is a number, the 3272th number
      data.frame(data.list[i])[nrow(data.frame(data.list[i])),4])             /  # this is the division
      (data.frame(data.list[i])[(nrow(data.frame(data.list[[i]]))-5),4])   -1
    data.frame(data.list[i])[3267,4] # another number, the 3267th number
    [(nrow(data.frame(data.list[[i]]))-5),4]
    
    # remark:
    # this code is first of all very convoluted
    # the codes the following
    # it takes 5 days of the data out
    # and then it compute the returns
    # STH / STH - 1
    # similar as lag function
    # data: 1,2,3,4,5 <= think of it as vector
    # vector[the 3272th number] / vector[the 3267th number]
    # todaystockprice = the previous 5 one => 1
    # fivedayslaterstockprice = the 5th one => 5
    # fivedayslaterstockprice / todaystockprice - 1
    
    # Note: return of a stock or return of a particular time
    # day1 stock is 100 
    # and day20 stock is 102
    # Question: what is the return from day 1 to day 2?
    # (a - b)/c = a/c - b/c
    # (102 - 100)/100 = 102/100 - 100/100 = 102/100 - 1
    
  }
  # note: the number we used to subtract in the code
  # is dependent on trading days NOT calendar days
  # fact: 252 trading days in a year
  for (i in c(1:nrow(all))){all[i,2] <- (data.frame(data.list[i])[nrow(data.frame(data.list[i])),4])/(data.frame(data.list[i])[(nrow(data.frame(data.list[i]))-25),4])-1}
  for (i in c(1:nrow(all))){all[i,3] <- (data.frame(data.list[i])[nrow(data.frame(data.list[i])),4])/(data.frame(data.list[i])[(nrow(data.frame(data.list[i]))-25*3),4])-1}
  for (i in c(1:nrow(all))){all[i,4] <- (data.frame(data.list[i])[nrow(data.frame(data.list[i])),4])/(data.frame(data.list[i])[(nrow(data.frame(data.list[i]))-252),4])-1}
  # this is not a very efficient way to write it
  # goal: you should be able to shorten it
  
  # Update column names:
  # remark: together there are 4 columns total
  # 4 is a choice by me
  colnames(all) <- c("Pre 5-Days",
                     "Pre 30-Days", 
                     "Pre Quarter",
                     "Pre Year")
  df <- data.frame(all)
  df
} # End of function

# Stock gif
library(quantmod)
getSymbols(
  c("AAPL", "MSFT", "GOOGL", "NVDA",     "AMZN", "GS", "LMT", "BA"),
  # i 'm downloading 8 stocks
  # i provide their names in a vector of characters
  to = paste0("2020-",01,"-01")
  # to = xxxxx <= this means the end of the data 
  # I want to download
)
head(AAPL); tail(AAPL)

# Test
data <- All.Indice.3D.Enter(AAPL, MSFT, GOOGL, NVDA,    AMZN, GS, LMT, BA)
rownames(data) <- c("AAPL", "MSFT", "GOOGL", "NVDA",     "AMZN", "GS", "LMT", "BA"); data

# Write GIF
beginT = Sys.time()
saveGIF({
  for (month in as.character(rep(1:12))) {
    getSymbols(c("AAPL", "MSFT", "GOOGL", "NVDA",     "AMZN", "GS", "LMT", "BA"),
               to = paste0("2020-",month,"-01")) # ; head(AAPL); tail(AAPL)
    data <- All.Indice.3D.Enter(AAPL, MSFT, GOOGL, NVDA,    AMZN, GS, LMT, BA)
    rownames(data) <- c("AAPL", "MSFT", "GOOGL", "NVDA",     "AMZN", "GS", "LMT", "BA"); data
    plot(data$Pre.5.Days~data$Pre.30.Days,
         xlim = c(-.3,.3), ylim = c(-0.2,0.2),
         main = paste0("Week/Month Returns Using Data Up to 2020-",month,"-01"),
         xlab = "Last Month Returns", ylab = "Last Week Returns",
         data = data[,c(1,2)], pch = 2)
    with(data[,c(1,2)], text(data$Pre.5.Days~data$Pre.30.Days,
                             labels = row.names(data[, c(1,2)]), pos = 4))
    
  }
}, movie.name = "Large_8_MKT_CAP_Path_BM.gif",
interval = 0.8, nmax = 30, 
ani.width = 600)
endT = Sys.time()
print(endT - beginT)


#### My Code ####

beginT = Sys.time()
tmpPackage = YinsCapital::QuantGrowthStrategy(
  symbolsIDX = c("SPY"),
  symbolsTECH = c("MSFT", "GOOGL", "FB"),
  symbolsFINANCIAL = c("V", "JPM", "MA"),
  symbolsINDUSTRIAL = c("HON", "LMT", "RTX"),
  symbolsCONSUMER = c("AAPL", "TSLA"),
  pastNforGrowth = 20,
  topGrowthNum = 4,
  intializedValue = 1,
  howMuchtoInvest = 1e4 )
endT = Sys.time()
print(endT - beginT)

AutoViz <- YinsCapital::AutoViz_Portfolio(
  base_dollar = 100,
  tickers = c("SPY","QQQ","AAPL","FB","AMZN"),
  past_days = 300)
AutoViz$cross_section_return_mat
AutoViz$recent_cross_section_return_mat
AutoViz$radial_col_P1
AutoViz$Ave_Ret

#### Source: Growth Strategy ####

tmp = YinsCapital::QuantGrowthStrategy()
tmp$Visualization
tmp$PLT1
tmp$ExeStocks
tmp$ExeShsEqWeight

# The code below is commented out
# and can be uncommented all together by 
# pressing ctrl + shift + c
# > YinsCapital::QuantGrowthStrategy
# function(
#   symbolsIDX = c("SPY"),
#   symbolsTECH = c("AAPL", "FB", "NVDA", "GOOGL", "AMZN"),
#   symbolsFINANCIAL = c("BAC", "GS", "JPM", "MS", "V", "PYPL"),
#   symbolsINDUSTRIAL = c("LMT", "GD", "BA", "CAT"),
#   symbolsCONSUMER = c("WMT", "TGT", "PEP", "DIS", "KO"),
#   pastNforGrowth = 20,
#   topGrowthNum = 4,
#   intializedValue = 1,
#   howMuchtoInvest = 1e4
# ) {
# 
#   # ASSET PRICING, GROWTH STRATEGY
#   # Carhart (1995)
#   # Source: https://onlinelibrary.wiley.com/doi/epdf/10.1111/j.1540-6261.1997.tb03808.x
#   # Original idea @ Carhart (1995) PhD Dissertation
# 
#   # Package
#   library(quantmod)
# 
#   # Initialize: an empty space for data
#   symbols <- c(symbolsIDX, symbolsTECH, symbolsFINANCIAL, symbolsINDUSTRIAL, symbolsCONSUMER)
#   myList <- list()
#   myList <- lapply(symbols, function(x) {getSymbols(x, from = as.Date("2000-01-04"),  auto.assign = FALSE)})
#   names(myList) <- symbols
# 
#   #################### Visualization ####################
# 
#   # Clean Data
#   AnnRet <- c()
#   AnnRet <- sapply(1:length(symbols), function(i) AnnRet <- c(
#     AnnRet,
#     round(mean(quantmod::yearlyReturn(myList[[i]])), 5) ))
#   QuartRet <- c()
#   QuartRet <- sapply(1:length(symbols), function(i) QuartRet <- c(
#     QuartRet,
#     round(mean(quantmod::quarterlyReturn(myList[[i]])), 5) ))
#   WeekRet <- c()
#   WeekRet <- sapply(1:length(symbols), function(i) WeekRet <- c(
#     WeekRet,
#     round(mean(quantmod::weeklyReturn(myList[[i]])), 5) ))
#   DayRet <- c()
#   DayRet <- sapply(1:length(symbols), function(i) DayRet <- c(
#     DayRet,
#     round(mean(quantmod::weeklyReturn(myList[[i]])), 5) ))
#   past10Vol <- c()
#   past10Vol <- sapply(1:length(symbols), function(i) past10Vol <- c(
#     past10Vol,
#     mean(tail(myList[[i]][, 5], 10)) ))
#   data_for_viz <- cbind(symbols, AnnRet, QuartRet, WeekRet, DayRet, past10Vol)
#   data_for_viz <- cbind(
#     data_for_viz,
#     AnnRetLev = ifelse(
#       AnnRet > mean(AnnRet) + sd(AnnRet), 1,
#       ifelse(AnnRet > mean(AnnRet), 2,
#              ifelse(AnnRet > mean(AnnRet) - sd(AnnRet), 3, 4))))
#   data_for_viz <- cbind(
#     data_for_viz,
#     QuartRetLev = ifelse(
#       QuartRet > mean(QuartRet) + sd(QuartRet), 1,
#       ifelse(QuartRet > mean(QuartRet), 2,
#              ifelse(QuartRet > mean(QuartRet) - sd(QuartRet), 3, 4))))
#   data_for_viz <- cbind(
#     data_for_viz,
#     sector = c(rep("Mkt", length(symbolsIDX)), rep("Tech", length(symbolsTECH)),
#                rep("Finance", length(symbolsFINANCIAL)), rep("Industrial", length(symbolsINDUSTRIAL)),
#                rep("Consumer", length(symbolsCONSUMER)) ) )
# 
#   # Visualization
#   library(plotly)
#   dtaViz <- data.frame(data_for_viz)
#   slope <- 2e-5*0.9
#   dtaViz$size <- sqrt(as.numeric(as.character(dtaViz$past10Vol)) * slope)
#   colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')
#   PLT1 <- plot_ly(dtaViz, x = ~DayRet, y = ~AnnRet, color = ~sector, size = ~size, colors = colors,
#                   type = 'scatter', mode = 'markers', sizes = c(min(dtaViz$size), max(dtaViz$size)),
#                   marker = list(symbol = 'circle', sizemode = 'diameter'),
#                   text = ~paste('symbols:', symbols,
#                                 '<br>Sector:', sector,
#                                 '<br>Ave. Daily Returns:', DayRet,
#                                 '<br>Ave. Weekly Returns:', AnnRet,
#                                 '<br>Ave. Quarterly Returns:', QuartRet)) %>%
#     layout(title = 'Data: Daily Return v. Annual Return \n(size: ave. of past 10 days volume; color: sector)',
#            xaxis = list(title = 'Daily Returns', gridcolor = 'rgb(0, 204, 0)'),
#            yaxis = list(title = 'Annual Returns', gridcolor = 'rgb(0, 204, 0)'))
# 
#   ################# End Visualization ###################
# 
#   # Return Data
#   returnData <- cbind()
#   lastPeriodReturnData <- cbind()
#   for (i in 1:length(symbols)) {
#     returnData <- cbind(
#       returnData,
#       quantmod::dailyReturn(as.xts(data.frame(myList[i]))))
#     lastPeriodReturnData <- cbind(
#       lastPeriodReturnData,
#       quantmod::dailyReturn(as.xts(data.frame(myList[i])))/lag(
#         quantmod::dailyReturn(as.xts(data.frame(myList[i]))), pastNforGrowth) - 1 )
#   } # end of loop
#   returnData <- data.frame(na.omit(returnData)); names(returnData) <- symbols
#   lastPeriodReturnData <- data.frame(na.omit(lastPeriodReturnData)); names(lastPeriodReturnData) <- symbols
# 
#   # Check
#   n1 <- nrow(returnData); n2 <- nrow(lastPeriodReturnData)
#   if (n1 > n2) {returnData <- returnData[-c(1:(n1-n2)), ]}
#   dim(returnData); dim(lastPeriodReturnData)
# 
#   # Create Growth Strategy
#   # Dynamic Programming:
#   #      start with a for loop and implement policy to concatenate different values
#   growthStrategy <- c()
#   selectedStockIndex <- c()
#   listNom <- rbind()
#   for (i in 1:nrow(returnData)) {
#     if (i < pastNforGrowth) {
#       growthStrategy <- c(growthStrategy, mean(as.numeric(as.character(returnData[i, ]))))
#     } else if (i %% pastNforGrowth == 0) {
#       Nom <- names(sort(lastPeriodReturnData[i, ], decreasing = TRUE)[1:topGrowthNum])
#       listNom <- rbind(listNom, Nom)
#       selectedStockIndex <- sort(sapply(1:length(Nom), function(j) {which(symbols == Nom[j])}))
#       growthStrategy <- c(
#         growthStrategy,
#         mean(as.numeric(as.character(returnData[i, selectedStockIndex]))))
#     } else {
#       growthStrategy <- c(
#         growthStrategy,
#         mean(as.numeric(as.character(returnData[i, selectedStockIndex]))))
#     }
#   } # end of loop
# 
#   # OLS Model
#   newData <- data.frame(Strategy = growthStrategy, MKT = returnData$SPY)
#   linearModel <- lm(Strategy~MKT, newData)
#   summary(linearModel)
# 
#   # List of Stocks Held
#   dateListNom <- c()
#   for (i in 1:nrow(returnData)) {
#     if (i %% pastNforGrowth == 0) {
#       dateListNom <- c(dateListNom, rownames(returnData)[i])
#     }
#   }
#   rownames(listNom) <- dateListNom
# 
#   # Performance Plot by Converting Returns back to Values
#   library(dygraphs)
#   proposedStrategyPath <- cumprod(1 + growthStrategy)
#   marketPath <- cumprod(1 + returnData$SPY)
#   pathData <- data.frame(Strategy = proposedStrategyPath, Market = marketPath)
#   rownames(pathData) <- rownames(returnData)
#   dyPlot <- dygraph(
#     pathData,
#     main = paste0(
#       "Proposed: Growth Strategy SR=", round(mean(newData[, 1])/sd(newData[, 1]), 4),
#       " vs. Benchmark: Market Index Fund SR=", round(mean(newData[, 2])/sd(newData[, 2]), 4)
#     )) %>%
#     dyRebase(value = intializedValue) %>%
#     dyLegend(show = "follow")
# 
#   # Update Holdings
#   for (k in 1:length(dateListNom)) {
#     dyPlot <- dyPlot %>%
#       dyEvent(dateListNom[k], paste0(listNom[k, ], collapse = "_"),
#               labelLoc = "bottom",
#               strokePattern = "dotted") }
# 
#   # Final Visualization
#   # dyPlot
# 
#   # Execution
#   eachWeight <- howMuchtoInvest/length(selectedStockIndex)
#   sharesVector <- c()
#   weightVector <- sapply(selectedStockIndex, function(x) {sharesVector <- c(
#     sharesVector, eachWeight/tail(data.frame(myList[x])[, 4], 1))})
#   #weightVector
# 
#   # Output
#   #return(list(Stocks = symbols, EqualWeight = weightVector))
# 
#   # Output
#   return(list(
#     Original_Stock_Data_List = myList,
#     Return_Data = returnData,
#     Return_Data_for_Past_Period = lastPeriodReturnData,
#     Name_of_Stock_Held = listNom,
#     Return_Data_New = newData,
#     Path_Data_New = pathData,
#     Linear_Model = linearModel,
#     Visualization = dyPlot,
#     PLT1 = PLT1,
#     ExeStocks = symbols[c(selectedStockIndex)],
#     ExeShsEqWeight = weightVector
#   ))
# }

