#### SIMULATED DATA ####

# n = 1000
# N = n + 2e3
# cutoff = round(n/N, 1)
# grade = rnorm(N) # X1
# extraCurrAct = rbinom(N, 5, 0.5) # X2
# harvardAdmission = rbinom(N, 1, 0.5) # Y
# harvardAdmission = 0.2*grade + 0.8*extraCurrAct + rnorm(N, sd = 0.0001) # Y
# y = as.numeric(harvardAdmission > .95*mean(harvardAdmission))
# table(y)
# all = data.frame(y, grade, extraCurrAct)
# head(all); dim(all)

#### REAL DATA ####

# DOWNLOAD DATA
# https://www.kaggle.com/uciml/breast-cancer-wisconsin-data
# all = read.csv("C:/Users/eagle/Desktop/archive (1)/data.csv")
all = read.csv("C:/Users/eagle/Desktop/project/data/archive/data.csv")
head(all,2); dim(all)
length(all$id)

# CLEANUP / PREPROCESSING
all = all[, -1]
all = all[, -ncol(all)]
dim(na.omit(all))
all = data.frame(y=all$diagnosis, all[,-1])
head(all$y, 10)
head(as.numeric(as.factor(all$y)))
all$y
class(all$y)
as.numeric(as.factor(all$y))-1 # 1: M, 0: B

all$y = as.numeric(as.factor(all$y))-1
head(all, 2)
cutoff = 0.8 # this means i'm using the previous 80% rows of the data as training and leave the last 20% of the rows of the data as test

#### MACHINE LEARNING ####

# MACHINE LEARNING: NEURAL NETWORK
dim(all[, -1])

# once it's done, it's easy to call
# as below
# let's try the experiment once
tmp = YinsLibrary::KerasNN(
  x = all[, -1], # This means I want the data frame all and I am excluding the 1st col
  y = as.numeric(as.factor(all$y))-1, # I take the column called $y$ and convert in 1's and 0's
  cutoff = 0.8,
  numberOfLayers = 2,
  l1.units = 128,
  epochs = 30)
tmp$Test_AUC

# how do we know the performance persist? 
# resample your input data *all* and repeat this function
result = list() # placeholder
for (i in 1:3) {
  set.seed(i)
  idx = sample(1:nrow(all), nrow(all))
  all = all[idx, ]
  tmp2 = YinsLibrary::KerasNN(
    x = all[, -1],
    y = all[, 1],
    cutoff = 0.9,
    numberOfLayers = 3,
    l1.units = 100,
    l2.units = 2,
    epochs = 20 )
  result[[i]] = tmp2$Test_AUC
} # done

result[[1]]
result[[2]]
result[[3]]

tmp2 = YinsLibrary::KerasNN(
  x = all[, -1],
  y = all[, 1],
  cutoff = 0.9,
  numberOfLayers = 3,
  l1.units = 100,
  l2.units = 2,
  epochs = 20 )
tmp2$Test_AUC


# overfitting => too many variables/parameters
# underfitting => too little variables/parameters
# neural network initialize with different numbers
# and it's due to chance the exact performance

# how to know performance is robust?
# Cross validation
# cutting the dataset into 3 partitions: training, validating, and testing
# 1. use training set and validating set to do model selection
# 2. after model selection, we have a winning candidate
# 3. use the winning candidate to test performance on the test set
# Note: cutoff is to separate train + val vs. test
#      val_split is to separate train vs. val

#### Source ####

# highlight what you need
# press ctrl+shift+c to comment/uncomment
# > YinsLibrary::KerasNN
# function(
#   x = all[, -1], # explanatory var
#   y = all[, 1], # resp. vaar
#   cutoff = .85, # cutoff to separate train and test, i.e. usually 70%-90%
#   validation_split = 1 - cutoff, # % of obs. for val set, i.e. usually 10%-30%
#   loss = 'categorical_crossentropy', # Bernoulli Random Variable (coin toss) => we derive the loss function from the likelihood function of the bernoulli random variable
#   # remark: for now, remember this type of loss function is related to 
#   #         the mathematical model of coin toss experiment
#   optimizer = optimizer_rmsprop(),
#   # remark: for now, think of rmsprop as an upgraded version of gradient descent (GD is the optimizer that we discussed in the morning, see notes)
#   batch_size = 128, # the number of samples that each round of forward + backward propagation algorithm will use
#   numberOfLayers = 1,
#   # if you enter any number greater than 1 (or design deeper neural network),
#   # your model will have more parameters to train
#   # the large number of parameters will increase your chance of detecting
#   # the pattern in the data
#   # dependent on data and it's trial and error
#   
#   
#   activation = 'relu', # act in the middle, common practice is relu () or sigmoid
#   # relu:
#   # the function relu(x) is defined as max(x, 0)
#   # sigmoid:
#   # recall in the morning, we discussed logistic regression and the link function
#   # is exactly where sigmoid is coming from => this is a mimic of logistic regression
#   useBias = FALSE,
#   finalactivation = 'softmax', # is the type of activation function in case the final layer has more than one neurons (2, 3, 4, ...)
#   l1.units = 128,
#   l2.units = 64,
#   epochs = 50 # one epoch = once forward prop + once backward prop
# ) {
#   
#   # Package
#   # (i) install python keras tensorflow
#   # (ii) install keras tensorflow for R in RStudio
#   library(keras)
#   
#   # Data
#   all <- data.frame(cbind(y, x))
#   
#   # Setup
#   train_idx <- 1:round(cutoff*nrow(all),0)
#   x_train <- as.matrix(all[train_idx, -1]) # training set variables (explanatory variable)
#   y_train <- as.matrix(all[train_idx, 1]) # training set target (response variable)
#   x_test <- as.matrix(all[-train_idx, -1]) # testing set
#   y_test <- as.matrix(all[-train_idx, 1]) # testing set
#   
#   # Check levels for response
#   # nrow(plyr::count(as.numeric(as.factor(all$y))-1))
#   number.of.levels <- nrow(plyr::count(y_train))
#   num_classes <- number.of.levels
#   
#   # To prepare this data for training we one-hot encode the
#   # vectors into binary class matrices using the Keras to_categorical() function
#   y_train <- to_categorical(y_train, number.of.levels)
#   y_test <- to_categorical(y_test, number.of.levels)
#   # note: this is tailored to the machine learning topic that you use
#   # for my code, I want to allow user to come in with a data that dictates
#   # more than two classes, i.e. if you want to do a 10-class classification,
#   # these two lines of code will take care of that (if you don't have these two lines
#   # of code, your algorithm might hit a bug because the output layer has dimensions
#   # that may or may not match correctly for the number of classes)
#   
#   # Defining the Model
#   # note: each model comes with its own sets of parameters
#   # model 0: 0 hidden layer, output layer (1 neuron) => regressor (cont)
#   # model 1: 0 hidden layer, output layer (2 neurons) => classifier
#   # model 2: 1 hidden layer (10 neurons), output layer (2 neurons)
#   if (numberOfLayers == 1) {
#     # remark: in case you build a brand new model, always start from here
#     model <- keras_model_sequential() # sequential here means I am coding the structure layer by layer (it is not referring to sequential model)
#     # what is the model above?
#     # it is telling computer I want a keras sequential object
#     # this sequential object allows me to add dense layer or other NN layers
#     model %>%
#       layer_dense(
#         units = number.of.levels, # how many neurons
#         input_shape = c(ncol(x_train)), # input shapes, this is the number of the columns
#         activation = finalactivation, # "sigmoid", "tanh", "relu", .......
#         use_bias = useBias # TRUE / FALSE (it is referring to beta_0 in the markdown file, i.e. recall beta_0 in linear model as well as logistic model)
#       ) # adding one dense layer (or one layer)
#     summary(model)
#   } else if (numberOfLayers == 2) {
#     model <- keras_model_sequential()
#     model %>%
#       layer_dense(units = l1.units, activation = activation, use_bias = useBias, input_shape = c(ncol(x_train))) %>%
#       layer_dense(units = number.of.levels, use_bias = useBias, activation = finalactivation)
#     summary(model)
#   } else if (numberOfLayers == 3) {
#     model <- keras_model_sequential()
#     model %>%
#       layer_dense(units = l1.units, activation = activation, use_bias = useBias, input_shape = c(ncol(x_train))) %>%
#       layer_dense(units = l2.units, activation = activation, use_bias = useBias) %>%
#       layer_dense(units = number.of.levels, use_bias = useBias, activation = finalactivation)
#     summary(model)
#   } else {
#     print("============== WARNING ==============")
#     print("Input value for [numberOfLayers] must be 1, 2, or 3.")
#     print("Since none of the values above are entered, the default is set to 1.")
#     print("=====================================")
#     model <- keras_model_sequential()
#     model %>%
#       layer_dense(
#         units = number.of.levels,
#         input_shape = c(ncol(x_train)),
#         activation = finalactivation,
#         use_bias = useBias)
#     summary(model)
#   }
#   
#   # Next, compile the model with appropriate loss function, optimizer, and metrics:
#   model %>% compile(
#     loss = loss,
#     optimizer = optimizer,
#     metrics = c('accuracy') )
#   # finishes the forward propagation
#   
#   # Training and Evaluation
#   history <- model %>% fit(
#     x_train, y_train,
#     epochs = epochs,
#     batch_size = batch_size,
#     validation_split = validation_split # 
#   ); plot(history)
#   # finishes the backward propagation
#   
#   # Evaluate the model's performance on the test data:
#   scores = model %>% evaluate(x_test, y_test)
#   
#   # Generate predictions on new data:
#   # note: this is tailored to your project
#   # for example, for my code, I want it to be a classification project
#   # so I build a classifier
#   # this means in evaluation procedure, I need to present 
#   # predicted classes
#   
#   y_test_hat <- model %>% predict_classes(x_test)
#   y_test_hat_raw <- model %>% predict_proba(x_test); colnames(y_test_hat_raw) = c(0:(num_classes-1))
#   y_test <- as.matrix(all[-train_idx, 1])
#   y_test <- as.numeric(as.character(y_test))
#   confusion.matrix <- table(Y_Hat = y_test_hat, Y = y_test)
#   test.acc <- sum(diag(confusion.matrix))/sum(confusion.matrix)
#   all.error <- plyr::count(y_test - cbind(y_test_hat))
#   y_test_eval_matrix <- cbind(
#     y_test=y_test,
#     y_test_hat=y_test_hat,
#     y_test_hat_raw=y_test_hat_raw )
#   
#   # AUC/ROC
#   if ((num_classes == 2) && (nrow(plyr::count(y_test_hat)) == 2)) {
#     y_test_for_roc = c(y_test)
#     y_test_class1_for_roc = c(y_test_hat_raw[, 2])
#     AUC_test <- pROC::roc(response = y_test_for_roc, predictor = y_test_class1_for_roc)
#   } else {
#     print("Estimate do not have enough levels.")
#     AUC_test <- 0.5
#   }
#   
#   # Return 
#   # in python: output a dictionary
#   return(
#     list(
#       Model = list(model = model, scores = scores),
#       x_train = x_train,
#       y_train = y_train,
#       x_test = x_test,
#       y_test = y_test,
#       y_test_hat = y_test_hat,
#       y_test_eval_matrix = y_test_eval_matrix,
#       Training.Plot = plot(history),
#       Confusion.Matrix = list(regularTable = confusion.matrix, prettyTable = knitr::kable(confusion.matrix)),
#       Testing.Accuracy = test.acc,
#       All.Types.of.Error = all.error,
#       Test_AUC = AUC_test
#     )
#   )
# }