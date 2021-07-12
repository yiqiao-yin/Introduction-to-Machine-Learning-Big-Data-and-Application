# Machine Learning Pipelines

## Stage I + Stage II

### Stage I: R & D

Question: research question that leads to business motivation?

Answer: 
- (1) mathematical model | linear regression: $y = \beta X_1$ where $X_1$: number of bedroom, y: housing price    
- (2) simulation (create a fake environment that copies the real environment but it's simple enough for the mathematical model to run many times so we can check every scenario rigorously) | remark: you only have this if no one has done it before | take a subset of your data (this is if you think your data is too large and you don't want to wait that long)
- (3) real data: what is the data? why is it helpful?    
- (4) build the algorithm | linear regression $X = ...$ and  $y = ...$ => run function => some results
- (5) backtest (cross-validation, train and test) => real results | let's use feature engineer, can we change X? | kmeans => feature engineer | Note: come to manager and see if the results are sound

### Stage II: Product Management

Question: will audience / clients use your product? if yes, how?

Answer:
- (1) the model / code / program / algorithm from Stage I, can you soft code it? | in your project, a github project that people can download your function | advanced: do a Shiny app
- (2) what are your assumptions?
    - (i) assumptions in your code? => data structures
    - (ii) assumptions in your model => machine learning concepts => customer service
- (3) maintaining software product => how to keep our audience / clients keep using our product?
        (i) in the future, there could be different usage in data structure => fix data structure
        (ii) in the future, clients require to use new data or new goals => sorry, go back to Stage I and start over

```
# Easy way
a + b
tmp = function(a, b) {return(a+b)}
tmp(1,2)
source("xxx/xxx/scripts.R")

# Hard way
# R Project
install.packages('')
devtools::install_git("github.com/yiqiao-yin/YinsLibrary.git")
```

### Feature Engineer

Suppose your data has $X_1$, $X_2$ and $y$

Model: $y = f(X_1, X_2)$ <= easy: $f()$ is a linear model
- (1) combine variables, create $X_3 = X_1 * X_2$, add $X_3$ create $X_4 = X_1^2$ create $X_5 = X2^.5$ note: you can keep adding new variables but don't overload (if your data has 1000 rows, try not to add to more than 1200 columns, i.e. ratio matters, not numbers)
- (2) shrink variables, $X_1$, $X_2$ <= replace $X_1$, $X_2$ with $X_3 = X_1 \cdot X_2$
- (3) kmeans, if X1 has 20 levels, use kmeans to reduce to 2 levels, and treat this as a new variable (either add in the data as a new column or replace $X_1$)
- (4) Principle Component (a famous dimension reduction technique)
- (5) Ridge/Lasso (famous regularization, dimension reduction, variable selection approach) (I want to penalize your linear regression model based on the number of variables, the higher the number of variables you used, the higher the loss)
- (6) transfer learning: special in deep learning (representation learning) many scholars have trained many sophisticated neural networks online and models / parameters are public suppose I have a new data, instead of training a brand new neural network from scratch I send my data into an already trained neural network to generate features then I use these newly generated features as my input variable to train a neural network Ex: Before: John Doe trained a sophisticated Neural Network (model (i)) with cats and dogs <= good!  Now: I have data to categorize huskies versus birds |if you find yourself in this situation  (your data has some similarity with some of the categories in a previously studied data) Proposal: instead of train a brand new neural network with huskies and birds => take a month I use model (i) to generate features based on (NOT THE CATS vs DOGS data) but on my new data then I am using these newly generated features to train a new model (model (ii))
