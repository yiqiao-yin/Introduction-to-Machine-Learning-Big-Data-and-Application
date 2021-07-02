# AI-project

Brief/Abstract: This is a sample guideline for your Capstone Project.

## Data

What is your data? What is the size of your data? What is the dimensions? What kind of variables are you using? Can you describe the length of your variables? Are there any interesting plots? 

Why is it interesting? What is the motivation? If you successfully build what you intend to build, what is the end game? 
- Example 1: hand gestures (rock, paper, scissors) => technology: train an AI model to recognize hand gestures => if successful, we can deploy this application as a video game and people can play game with the computer => less helpful (comparing with the next example)
- Example 2: hand gestures (American Sign Language) => technology: train an AI model to recognize hand gestures => if successful, we can deploy this application as a communication tool for people with disabilities => more helpful (community impact!!!!) 

## Benchmark 

In scholarly writing, this is also called *Literature Review*. In this section, we would briefly explain what are some existing models out there and what their performances are. 

- Example: check out [Kaggle](https://www.kaggle.com/datasets)
- Example: check out [UCI](https://archive.ics.uci.edu/ml/index.php)
- Example: check out [PaperWithCode](https://paperswithcode.com/datasets)

## Proposed Model/Algorithm

This section describes the proposed model and the architecture (some diagram).

- Easy way: you can adopt one of the models in the benchmark and update new sets of parameters. Let's say I have a data with one variable $X$. This model $f(\cdot)$ is a function that learns from $X$ and produce an educated guess of $Y$. I proposed to use $X^2$ and instead of using the old educated guess of $\hat{Y}_1 = f(X)$ we are using $\hat{Y}_2 = f(X^2)$. I can show with empirical results that $\hat{Y}_1$ is less accurate than $\hat{Y}_2$.

- Hard way: you can design a new model. Originally, we have the data $X$ and the model $f(\cdot)$ with educated guess of $\hat{Y}_1 = f(X)$. Now I propose a new model $g(\cdot)$. Then we have new educated guess $\hat{Y}_2 = g(X)$. I land on presenting the empirical evidence that $\hat{Y}_2$ is more accurate then $\hat{Y}_1$. A good example is in this [post](https://towardsdatascience.com/lazy-predict-fit-and-evaluate-all-the-models-from-scikit-learn-with-a-single-line-of-code-7fe510c7281). One can write each function yourself or use packages such as *lazypredict* to come up with many results once. Next one can propose to use a different model with high accuracy.

Remark: there are situations when we need to insert code in a markdown file. We can do the following

```
x = rnorm(10)
hist(x)
```

