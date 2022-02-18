# Day 1

Let us start with a small motivation. We have seen the "scan his fight pattern" in the course video. We had great conversations about what and how to collect the data. From there we discussed the potential data structures and the type of data we can start a data science project.

## Data

In a data science project, there are explanatory variables and response variable. We name them $X$ and $Y$ respectively. The explanatory variables are features in the data that we can use to train an AI model on. The response variable is the target we want the AI to make educated guesses of.

## Taxonomy

From the data, the conversation led us to define the following taxonomy of machine learning. 

Supervised Learning: It is the type of machine learning tasks that we know exactly what are the explanatory variables $X$ and what is the response variable $Y$. It has two branches: regression problem and classification. 

In data structure, we discussed that a random variable $Y$ can be continuous and discrete. If $Y$ is continuous, we have a regression problem. If $Y$ is discrete, we have a classification problem.

## Pipeline

The data science pipeline has two stages: stage I and stage II.

Stage I: this stage refers to research period. It refers to the data science procedure that you are exploring a function $f(\cdot)$ such that you can use $X$ to make educated guesses on $Y$ as accurately as possible. In other words, we can refer to the following diagram:
$$x, y \rightarrow \hat{y} := f(\cdot)$$
and once this $f(\cdot)$ is successfully found we have ourselves a successful model. Here "success" means that the educated $\hat{Y}$ that is based on $f(X)$ is accurate at predicting $Y$ (the real response variable).

Stage II: Given stage I already occured, we have a model $f(\cdot)$. We can deploy the model in a software package and publish our code as a final production for the data science community. 
