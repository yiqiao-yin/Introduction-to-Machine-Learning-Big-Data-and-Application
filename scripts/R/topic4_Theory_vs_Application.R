# I. Application of Bernoulli Random Variable
# Library
library(quantmod)
getSymbols("AAPL")
getSymbols("FB")
head(AAPL); tail(AAPL)
head(FB); tail(FB)
returnAVec = quantmod::dailyReturn(AAPL$AAPL.Close)[1356:length(quantmod::dailyReturn(AAPL$AAPL.Close))]
returnA = mean(returnAVec)
sdA = sd(returnAVec)
returnBVec = quantmod::dailyReturn(FB$FB.Close)
returnB = mean(returnBVec)
sdB = sd(returnBVec)
weightA = 0.3
weightB = 1 - weightA
portfolioReturn = weightA * returnA + weightB * returnB # this return (if converted to annual performance) is Forbes100 level even though it looks like a small number using daily unit
# covariance formula: var(X1 + X2) = var(X1) + 2cov(X1, X2) + var(X2)
portfolioVolatility = (weightA^2*sdA^2 + 2*cov(returnAVec, returnBVec)*weightA*weightB + weightB^2*sdB^2)^(.5)
MPT_data = sapply(
  seq(0, 1, 0.01),
  function(s) {
    weightA = s
    weightB = 1 - s
    portfolioReturn = weightA * returnA + weightB * returnB # this return (if converted to annual performance) is Forbes100 level even though it looks like a small number using daily unit
    portfolioVolatility = (weightA^2*sdA^2 + 2*cov(returnAVec, returnBVec)*weightA*weightB + weightB^2*sdB^2)^(.5)
    return(c(portfolioReturn, portfolioVolatility))
  }
)
MPT_data = data.frame(t(MPT_data))
colnames(MPT_data) = c("Return", "Volatility(SD)")
plot(MPT_data$`Volatility(SD)`, MPT_data$Return, xlab = "Volatility(SD)", ylab = "Return", 
     main = "Modern Portfolio Theory", pch = "*")
vector_of_sharpe_ratio = MPT_data$Return / MPT_data$`Volatility(SD)`
max(vector_of_sharpe_ratio)
bestIndex = which(vector_of_sharpe_ratio == max(vector_of_sharpe_ratio)); bestIndex
bestCombo = MPT_data[bestIndex, ]
abline(a = 0, b = max(vector_of_sharpe_ratio))
bestWeightA = seq(0, 1, 0.01)[bestIndex]
bestWeightB = 1 - bestWeightA

# Look for optimal point
# Optimal: the largest return & the smallest risk (SD)

# II. Application of Uniform Random Variable & Law of Large Numbers
# Library
library(animation)

## Plot Monte Carlo Simulation of Pi
saveGIF({
  ## Define a function to output a plot of pi
  nRange <- seq(1e2, 1e4, 2e2)
  pi_hat_vec <- rep(NA, length(nRange))
  for (N in nRange) {
    x <- runif(N)
    y <- runif(N)
    d <- sqrt(x^2 + y^2)
    label <- ifelse(d < 1, 1, 0)
    pi_hat <- round(4*plyr::count(label)[2,2]/N,3)
    pi_hat_vec[which(N == nRange)] <- pi_hat
    par(mfrow=c(1,2))
    plot(
      x, y,
      col = label+1,
      main = paste0(
        "Simulation of Pi: N=", N,
        "; \nApprox. Value of Pi=", pi_hat),
      pch = 20, cex = 1)
    plot(
      nRange, pi_hat_vec, type = "both",
      main = "Path for Simulated Pi"); 
    lines(nRange, y = rep(pi, length(nRange)))
  }
}, movie.name = "C:/Users/eagle/OneDrive/PalmDrive/Classrooms/StatsProgram/2021Winter/Scripts/mc-sim-pi.gif", 
# please change above to your own address
interval = 0.8, nmax = 30, ani.width = 480)
