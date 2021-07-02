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
