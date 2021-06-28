#### PART I: LET US CODE GRADIENT DESCENT ####

# READ:
# This is a gradient descent on linear models 
# note that here the loss function is Mean Square Error
# the weight (referring to the parameter) is under 
# linearity assumption, i.e. y ~ mx + constant

# ATTACH DATA
attach(mtcars)

# DEFINE DATA
x = disp
y = mpg
learn_rate = 0.0000293
conv_threshold = 0.001 
n = 32
max_iter = 500000

# SET UP PARAMETERS
plot(x, y, col = "blue", pch = 20)
m <- runif(1, 0, 1)
c <- runif(1, 0, 1)
# linear model (1) <= this is called a regression problem, meaning the var Y is continuous
yhat <- m * x + c # this is the linear model, here the weight (or parameter) is m
# logistic model (2) <= this is called a classification problem, meaning the var Y is a probability
yhat <- 1/(1 + exp(-(m * x + c))) # this is the logistic model, here the weight is m ######### THIS IS A SINGLE LAYER NEURAL NETWORK WITH ONE NEURON!!!!!!!!!
# NEURAL NETWORK:
# there is a linear component: mx + c
# we plug this in a non-linear component: 1/(1 + exp(-XXXXXXX))
# and we use gradient descent to find the optimal (best) weight: m and c
# to guess y with as little error as possible
MSE <- sum((y - yhat) ^ 2) / n
converged = F
iterations = 0
while(converged == F) {
  ## Implement the gradient descent algorithm
  m_new <- m - learn_rate * ((1 / n) * (sum((yhat - y) * x))) # this is from model (1)
  c_new <- c - learn_rate * ((1 / n) * (sum(yhat - y))) # this is from model (1)
  #### you need the code for model (2)
  #### you need to derive the formula based on logistic model
  #### and write the gradient descent part here
  m_new <- m - # something
    
    
    #### code ends here
    m <- m_new
  c <- c_new
  yhat <- m * x + c
  MSE_new <- sum((y - yhat) ^ 2) / n
  print(paste("Iter=", iterations, "; Optimal intercept: ", round(c, 2), "; Optimal slope: ", round(m, 2), "; Loss: ", MSE_new))
  if(MSE - MSE_new <= conv_threshold) {
    abline(c, m) 
    converged = T
    print(paste("Optimal intercept:", c, "Optimal slope:", m))
  }
  iterations = iterations + 1
  if(iterations > max_iter) { 
    abline(c, m) 
    converged = T
    print(paste("Optimal intercept:", c, "Optimal slope:", m))
  }
}

#### PART II: PUT IT IN PRODUCTION ####

# READ
# "PUT IN PRODUCTION" means that I have a function that I am happy with
# now I am turning that into a function with a short-handed name so that
# I can call it anytime I want

# Run the function: this is linear model, it's a benchmark
lm(mpg~disp, mtcars) # use MLE

# Load the data
attach(mtcars)

# Define function
gradientDesc <- function(x, y, learn_rate, conv_threshold, n, max_iter) {
  plot(x, y, col = "blue", pch = 20)
  m <- runif(1, 0, 1)
  c <- runif(1, 0, 1)
  yhat <- m * x + c
  MSE <- sum((y - yhat) ^ 2) / n
  converged = F
  iterations = 0
  while(converged == F) {
    ## Implement the gradient descent algorithm
    m_new <- m - learn_rate * ((1 / n) * (sum((yhat - y) * x)))
    c_new <- c - learn_rate * ((1 / n) * (sum(yhat - y)))
    m <- m_new
    c <- c_new
    yhat <- m * x + c
    MSE_new <- sum((y - yhat) ^ 2) / n
    if(MSE - MSE_new <= conv_threshold) {
      abline(c, m) 
      converged = T
      return(paste("Optimal intercept:", c, "Optimal slope:", m))
    }
    iterations = iterations + 1
    if(iterations > max_iter) { 
      abline(c, m) 
      converged = T
      return(paste("Optimal intercept:", c, "Optimal slope:", m))
    }
  }
} # End of function

# Run the function 
gradientDesc(disp, mpg, 0.001, 0.001, 32, 3000000)
lm(mpg~disp, mtcars)

# Reference
# https://www.r-bloggers.com/2017/02/implementing-the-gradient-descent-algorithm-in-r/