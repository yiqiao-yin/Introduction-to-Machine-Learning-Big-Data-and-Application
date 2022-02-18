# Linear Regression

Linear regression is the statistical model that learns from $X$ and predicts $Y$. Model is usually formulated in the following setup. 

Suppose we are given $X_1$ and $X_2$, i.e. call $X = \{X_1, X_2\}$. Suppose also we want to predict $Y$. The term regression comes from regress which means the goal is to minimize the following:
$$\mathbb{E}(Y - \mathbb{E}(Y|X))$$

Note:
- $Y$: this is the target, it is something you want to forecast, it is usually continuous in this framework
- $X$: this is a set of variables $X_1$ and $X_2$, they record certain information of an observation that help us predict $Y$
- $\mathbb{E}(...)$: this means the expectation of something (recall empirical average)
- $\mathbb{E}(Y|X)$: this is the average of $Y$ given the information of $X$, it is an educated guess of what $Y$ can be based on the information of $X$
- $\mathbb{E}(Y - \mathbb{E}(...))$: this is the loss function, the mistakes our educated guess is making when we compare them with the real target $Y$

Now we know the problem, the model of linear regression takes the following form:
$$Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \epsilon$$

Note:
- $\beta$'s are linear coefficients, there are fixed ways of finding them
- $\epsilon$: this is the error term, it is whatever this formula cannot model (or cannot learn)
- $\beta_0$: this is the constant term

Assumptions:
- Linearity: we first assume that the model is in additive form that consists of the variables $X$'s
- Multivariate normality: this assumes that the data is coming from normal distribution and same with when we have more than one variables recall the *rnorm()* function that we used in R
- No multicollinearity: this assumes your variables are *independent* with each other
- No auto-correlation: this is specifically in time-series data set, ex: in stock data, there is auto-correlation (this means today's stock price/return is highly correlated with yesterdays')
- Homoscedasticity: this means we have constant variance in our model (refer to the error term $\epsilon$), ex: in stock market, the volatility (which is computed from the variance) is not constant, in this case, you want to either avoid using the linear regression algorithm or use new sets of variables 

For example, let $X_1$ be number of bedrooms and let $X_2$ be squre foot of the real estate. Suppose $Y$ is our target and it is the sales price of this real estate. In short, this dataframe has 3 columns (sales price, number of bedrooms, and square foot). The linear regression model takes the following form
$$Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \epsilon$$
while $\epsilon$ is the error (aka noise, referring the component in the data that cannot be modeled by $X_1$ and $X_2$). For example, say the model is done. We have $\beta_1 = 3$. This means one unit of increase in the number of bedrooms can increase the sales price by 3. 

In general, we can write
$$Y = \beta_0 + \sum_{j=1}^p \beta_j X_j + \epsilon$$
which allows a multivariate linear regression model to have $p$ variables.

# Logistic Regression

The logistic regression model assumes that the log-odds (this is the ratio of probability an observation is one class versus the probability that this same observation is not in this class) of an observation $Y$ can be expressed using linear model. This can be considered as a linear model get tossed inside a link function (a link function is a non-linear function).
$$\log\bigg(\frac{\mathbb{P}(Y=1|X)}{1 - \mathbb{P}(Y=1|X)}\bigg) = \sum_{j=1}^K \beta_j X_j$$
and here the log-odds is the ratio of $\mathbb{P}(Y)$ over $1 - \mathbb{P}(Y)$. Here we use a link function called *logit*.

Let us derive what $\mathbb{P}(Y)$ is based on the above model.

How to interpret it intuitively? Check [here](https://towardsdatascience.com/logistic-regression-derived-from-intuition-d1211fc09b10)
Logistic Regression Explained: [StatQuest](https://www.youtube.com/watch?v=yIYKR4sgzI8)

# Machine Learning Introduction

A basic concept in machine learning is the partition on the same data set. The purpose of partitioning data set is to ensure that we have an honest artificial environment for the machines to learn and to have their performances examined. The learning or the training procedure of a machine is done using training set. This is a scenario where I know the true label (aka ground truth). Once I am happy with the results, we will test the performance on a test set that is never seen before. In some occasion where there is tuning procedure, we need separate training and validating environment to check the performance of a machine under different models or tuning parameters. This is the situation where we need to partition our raw data into training, validating, and testing. Suppose we have two models: $f_1()$ and $f_2()$. We can use $f_1()$ and $f_2()$ both on training and validating set. We suppose validating set was not seen by $f_1()$ and $f_2()$ during the training process. We then observe the validating performance and we can pick the best one, say $f_1()$. Last, we can use this model $f_1()$ to performance on the test set to see what the test result it.  
- Training Set vs. Validating Set vs. Testing Set: [video](https://www.youtube.com/watch?v=PIRQY6xmNZY)
- Bias Variance Trade-off: [video](https://youtu.be/EuBBz3bI-aA)

Loss function or Cost function is another big component of machine learning. In plain English, a loss function between two vectors refer to some sort of measure of distance between these two vectors. Based on the definition of different types of loss functions, we can come up with certain measure of how far away one vector is from another. Intuitively speaking, one vector can be the ground truth. Another vector can be our educated guesses from our machine learning algorithm. It is obvious that we want the educated guesses to be as close to the ground truth as possible. 
- Here is a quick python tutorial of using loss function such as mean square error, [here](https://www.youtube.com/watch?v=uD1Dfz0aqkA)
- A list of different video, [here](https://www.youtube.com/watch?v=QBbC3Cjsnjg)
