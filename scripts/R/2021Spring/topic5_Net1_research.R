# OVERVIEW OF TENSORFLOR IN R
# TF (tensorflow) is developed in Py
# Here we call Py in RStudio (py => r)

# Homework:
# goal is to run through the script
# without understanding of the math
# behind it and pay attention to the 
# script and bugs first *** 

# we will talk about the math behind
# the code next.

library(keras)

mnist = dataset_mnist()
mnist$train$x = mnist$train$x/225
mnist$test$x = mnist$test$x/255

# Comment: 
# if dim = 60k x 28 x 28, we call it tensor (a cube)
# if dim = 60k x 784, we call it flattened 

model <- keras_model_sequential() %>% 
  layer_flatten(input_shape = c(28, 28)) %>% 
  layer_dense(units = 128, activation = "relu") %>% 
  # layer_dropout(0.2) %>% 
  layer_dense(10, activation = "softmax")

summary(model)

model %>% 
  compile(
    loss = "sparse_categorical_crossentropy",
    optimizer = "adam",
    metrics = "accuracy"
  )

model %>% 
  fit(
    x = mnist$train$x, y = mnist$train$y,
    epochs = 5,
    validation_split = 0.3,
    verbose = 1
  )

predictions = predict(model, mnist$test$x)
head(predictions, 2)
dim(predictions)

realY = mnist$test$y
estimatedY = apply(predictions, 1, which.max) - 1
confTable = table(realY, estimatedY)
confTable
sum(diag(confTable)) / sum(confTable)
