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

