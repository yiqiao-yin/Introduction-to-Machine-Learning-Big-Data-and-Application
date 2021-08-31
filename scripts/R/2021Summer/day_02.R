#### Think with Data ####

# Topic: how to visualize Pi?
# Pi = 3.141592653
# in case you don't have the package
# install.packages("plyr") # this installs the package named "plyr"
# in statistics, there is a random variable called uniform random variable
# in r, we use runif() to create this random variable 
# (name: r => random variable, unif => uniform)
# runif(n = sample size, min = 1, max = 3.5)
runif(n = 10, min = 1.2, max = 4)
?runif
?hist
hist(runif(n = 10000, min = 1, max = 3.5))

# Experiment: Data
# N = 100000 # sample size
par(mfrow=c(2,3)) # par() refers to partition of your plots, mfrow is asking you for dimensions of the plots
# increase N: (i) uniformly or (ii) exponentially
# (i) c(10, 20, 30, 40)
# (ii) c(10, 100, 1000, ...., 100000000)
N = 2
for (N in c(10, 100, 200,   500, 1000, 10000)) {
  # Data:
  # create two vectors: x and y
  # both x and y have length of N
  # N = 2
  x = runif(N) # draw N samples from uniform random variable / uniform distribution
  y = runif(N) # same here
  d = sqrt(x^2 + y^2) # compute square root of sum of squares of x and y
  # Rejection Region
  label = ifelse(d < 1, 1, 0) # create label for coloring purpose
  # convention: packageName::functionName(enter inputs) 
  pi_hat = 4*plyr::count(label)[2,2]/N # recover pi (here I compute an estimated number of pi)
  # Plot
  plot(x, y, col = label+1, main = paste0("Est: value of Pi = ", pi_hat))
} # Done

# Call a library
# install.packages("animation")
library(animation)
# saveGIF({YOUR CODE GOES HERE!}) # this function will create a GIF file
saveGIF({
  ## Define a function to output a plot of pi
  ## 1e1 = 1 * 10^1
  ## 1e2 = 1 * 10^2
  ## 2e2 = 2 * 10^2
  nRange <- seq(1e2, 1e4, 3e2) # seq() means sequence
  # length(nRange)
  # set seed is for reproducibility
  # set.seed(any_number_you_like)
  
  ## Create a placeholder to store the recovered pi values
  ## every time we run the experiment with a different N
  ## rep(): this means replicate(theThingsYouWantToReplicate, numberOfTimesOfReplication)
  pi_hat_vec <- rep(NA, length(nRange))
  for (N in nRange) {
    x <- runif(N)
    y <- runif(N)
    d <- sqrt(x^2 + y^2)
    label <- ifelse(d < 1, 1, 0)
    pi_hat <- round(4*plyr::count(label)[2,2]/N,3)
    pi_hat_vec[which(N == nRange)] <- pi_hat # this line saves the estimated pi value in the placeholder called: pi_hat_vec
    # I want to create plots
    # with partitiion defined using dimension (1,2) we use mfrow to define this dimension
    par(mfrow=c(1,2))
    # plot() function assumes cartesian coordinate: an x-y coordinate structure
    # first plot
    plot(
      x, y,
      col = label+1,
      main = paste0(
        "Simulation of Pi: N=", N,
        "; \nApprox. Value of Pi=", pi_hat),
      pch = 20, cex = 1)
    # second plot
    plot(
      nRange, # x-axis and all the numbers allowed
      pi_hat_vec, # y-axis and all the numers allowed are essentially updated placeholder vector with each entries to be recovered Pi value from each round of the for loop
      type = "both", # "both" means "both dots and lines", "p" = point, "l" = line
      main = "Path for Simulated Pi"); # main => the title
    lines(nRange, y = rep(pi, length(nRange))) # this adds a line onto the prior plot, with entries defined as y
    # here the y is referring to the entry in lines() function and it's the theoretical value of pi
  }
},  movie.name = "C:/Users/eagle/Desktop/random-names.gif", interval = 0.8, nmax = 30, 
ani.width = 600)


# note
plyr::count(label)[1,1] # in R, starts with 1; in python, starts with 0

# note
?which
1 == 2
class(1 == 2)
2 == 5 - 3
N = 10
nRange = c(10, 100, 1000)
which(N == nRange) # which of the first object is equal to the second object

# note
# set.seed(any_integer_you_like) # reproducibility
set.seed(2020); runif(3)
set.seed(2021); runif(3)

# Homework: Monte Carlo Simulation
# some people Monte Carlo Markov Chain (MCMC)
# Monte Carlo: name of the simulation
# Markov Chain: name of the mathematical model

# normal random variable
?rnorm # mean refers to the center and SD (standard deviation) refers to how wide the data are away from the mean
rnorm(10, mean =  0, sd = 1)
mean(rnorm(1000, 0, 1))
hist(rnorm(1000, 0, 1))
hist(rnorm(1000, 1, 1))
par(mfrow=c(1,2))
hist(rnorm(1000, 0, 1))
hist(rnorm(1000, 0, 3))

# Homework
# problem statement:
# create N paths 
# (path: refers to the lines in the plot below) of 
# data (same with path in the sample code below)
# and you can pick any number for length L 
# (same with the number 0 to 250 below, it's the x coordinate range)
# that are drawn from normal random variables, 
# i.e. hint (i): using rnorm() function
#      hint (ii): start from the same dot
#      hint (iii): 
# and plot the N paths in the same plots
# you should expect to see N plots start from one number and fan out towards the right

# Thought Process:
# What is the data I need? Hint: use rnorm() to generate data 
# | trick: I am using rnorm() output as my original data, and then I 
# added 1 to represent the growth form previous data points assuming starting with 1
par(mfrow=c(1,2))
L = 50
dta1 = rnorm(L, 0, 0.05) # instead of this, which is the original data
plot(dta1, type = "l")
dta2 = dta1 + 1 # I am plotting this updated data
dta3 = cumprod(dta2) # use a function cumprod(), this means cumulative product, it will accumulate the product of all numbers in the series the user provided
plot(dta3, type = "l")
# Given the data, what do I need to do to create the plot? Hint: you can use plot() function or matplot() (I'll leave as your own research what that does.)
# Good visualization: color coding, type of plot, title/subtitle, name of the axis

# Bonus:
# Provide one paragraph of intuition how this can help you interpret
# the stock market? Hint: think about the stock returns, stock price, and volatility

# tmp = YinsCapital::MCMC_Simulation(
#   seed = 2021, # set seed => reproducibility
#   path = 20, # number of path, equivalent to N above
#   expected_return = 0.001, # theoretical mean, equivalent to mean in rnorm() function
#   expected_sd = 0.02, # .... equivalent to sd in rnorm() function
#   num_of_days = 250, # this is length of the data, equivalent to 1000 that we tried above
#   type = "l" # presume that we are plotting lines right now, see plot()
# )

# TODO:
# (i) list of R packages
# quantmod, stats, knitr, glmnet, keras, randomForest, pROC
# (ii) installation
# please install R first and then install RStudio (IDE)

#### Homework ####

# Homework: Monte Carlo Simulation
# some people Monte Carlo Markov Chain (MCMC)
# Monte Carlo: name of the simulation
# Markov Chain: name of the mathematical model

# normal random variable
?rnorm # mean refers to the center and SD (standard deviation) refers to how wide the data are away from the mean
rnorm(10, mean =  0, sd = 1)
mean(rnorm(1000, 0, 1))
hist(rnorm(1000, 0, 1))
hist(rnorm(1000, 1, 1))
par(mfrow=c(1,2))
hist(rnorm(1000, 0, 1))
hist(rnorm(1000, 0, 3))

# Homework
# problem statement:
# create N paths 
# (path: refers to the lines in the plot below) of 
# data (same with path in the sample code below)
# and you can pick any number for length L 
# (same with the number 0 to 250 below, it's the x coordinate range)
# that are drawn from normal random variables, 
# i.e. hint (i): using rnorm() function
#      hint (ii): start from the same dot
#      hint (iii): 
# and plot the N paths in the same plots
# you should expect to see N plots start from one number and fan out towards the right

# Thought Process:
# What is the data I need? Hint: use rnorm() to generate data 
# | trick: I am using rnorm() output as my original data, and then I 
# added 1 to represent the growth form previous data points assuming starting with 1
par(mfrow=c(1,2))
L = 50
dta1 = rnorm(L, 0, 0.05) # instead of this, which is the original data
plot(dta1, type = "l")
dta2 = dta1 + 1 # I am plotting this updated data
dta3 = cumprod(dta2) # use a function cumprod(), this means cumulative product, it will accumulate the product of all numbers in the series the user provided
plot(dta3, type = "l")
# Given the data, what do I need to do to create the plot? Hint: you can use plot() function or matplot() (I'll leave as your own research what that does.)
# Good visualization: color coding, type of plot, title/subtitle, name of the axis

# Bonus:
# Provide one paragraph of intuition how this can help you interpret
# the stock market? Hint: think about the stock returns, stock price, and volatility

# tmp = YinsCapital::MCMC_Simulation(
#   seed = 2021, # set seed => reproducibility
#   path = 20, # number of path, equivalent to N above
#   expected_return = 0.001, # theoretical mean, equivalent to mean in rnorm() function
#   expected_sd = 0.02, # .... equivalent to sd in rnorm() function
#   num_of_days = 250, # this is length of the data, equivalent to 1000 that we tried above
#   type = "l" # presume that we are plotting lines right now, see plot()
# )

# TODO:
# (i) list of R packages
# quantmod, stats, knitr, glmnet, keras, randomForest, pROC
# (ii) installation
# please install R first and then install RStudio (IDE)


#### Software Production ####

# Software Production
# focus on pipeline
# recall: stage (i) + stage (ii)
# stage (ii) refers software production [THINK ABOUT IT RIGHT NOW]
# define a function: addition
a = 3
b = 2
a + b
tmp = function(a, b) {
  return(a + b)
} # End of function

# For this example
# remark: here you want to softcode your production pipeline
#         the input and output is tailored to your needs
#         or the clients' needs
newFCT = function(L = 20) {
  if (is.numeric(L) == TRUE) {
    par(mfrow=c(1,2))
    # L = 50 <= I want it to be soft coded
    dta1 = rnorm(L, 0, 0.05) # instead of this, which is the original data
    plot(dta1, type = "l")
    dta2 = dta1 + 1 # I am plotting this updated data
    dta3 = cumprod(dta2) # use a function cumprod(), this means cumulative product, it will accumulate the product of all numbers in the series the user provided
    plot(dta3, type = "l")
  } else {
    dta3 = "404 error!!!!"
  }
  return(list(
    originaldata = dta1, # this is original data 
    finaldata = dta3) # this is updated data 
    # the purpose of having a list of things is a way of fact checking 
    # my own production code
  ) # output a list that I can call name from the list obj.
} # End of function

# Try it: output is completely dependent on 
#         clients' needs or yours
tmpHolder = newFCT(L = 50)
tmpHolder$finaldata

# Note
list() # this defines a list, in python, I can do a = [1, 2, 3], which is a list
tmpList = list(a = 1, b = c(2,3,4))
tmpList$a
tmpList$b


