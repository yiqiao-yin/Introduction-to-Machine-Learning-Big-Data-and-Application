

# Download Stock
ticker = "AAPL" # parameter above
quantmod::getSymbols(ticker)

# Process Data
stockData = (AAPL$AAPL.Close - mean(AAPL$AAPL.Close)) / max(AAPL$AAPL.Close)
data = stockData
for (j in 2:100) {
  data = cbind(data, lag(stockData, j))
} # done
head(data); dim(data)
data = data.frame(na.omit(data))
colnames(data) = c("Y", paste0("Lag", 2:100))
head(data); dim(data)
X = data[, -1] # except for col 1
y = data[, 1] # this is exactly col 1

# Run RNN
tmp = YinsLibrary::KerasNNRegressor(
  x = X,
  y = y,
  cutoff = 0.97,
  numberOfHiddenLayers = 3,
  activation = "relu",
  useBias = TRUE,
  dropoutRate = 0.15,
  epochs = 100)
tmp$Result$MSE_test
par(mfrow=c(1,1))
testSetRecover = apply(tmp$y_test_eval_matrix, 2, function(C) C*max(AAPL$AAPL.Close) + mean(AAPL$AAPL.Close))
matplot(testSetRecover,
        type = "l",
        xlab = "Test Set Observation: Day Index",
        ylab = "Price (Receoved)",
        main = "Black: Real Data vs. Red (dotted): Prediction")
par(mfrow=c(1,2))
tmp$y_test_eval_matrix[,1]
tmp$y_test_eval_matrix[,2]
matplot(tmp$y_test_eval_matrix[,1], type = "l")
matplot(tmp$y_test_eval_matrix[,2], type = "l")

# Sampling
# The following code run the same algorithm but use different data
# the first data take the first 10 columns (this means lag 1 to lag 10)
# the second takes the first 20 columns (lag 1 to lag 20)
# the third takes the first 50 columns (lag 1 to lag 50)
# the last takes all columns
# Each data each experiment we repeat 10 times and store errors
# in the end we plot errors bars using boxplot()
errors1 = c()
errors2 = c()
errors3 = c()
errors4 = c()
for (i in 1:10) {
  # Run RNN
  tmp1 = YinsLibrary::KerasNNRegressor(
    x = X[,c(1:10)],
    y = y,
    cutoff = 0.97,
    numberOfHiddenLayers = 3,
    activation = "relu",
    useBias = TRUE,
    dropoutRate = 0.15,
    epochs = 20)
  errors1 = c(errors1, tmp1$Result$MSE_test)
  tmp2 = YinsLibrary::KerasNNRegressor(
    x = X[,c(1:20)],
    y = y,
    cutoff = 0.97,
    numberOfHiddenLayers = 3,
    activation = "relu",
    useBias = TRUE,
    dropoutRate = 0.15,
    epochs = 20)
  errors2 = c(errors2, tmp2$Result$MSE_test)
  tmp3 = YinsLibrary::KerasNNRegressor(
    x = X[,c(1:50)],
    y = y,
    cutoff = 0.97,
    numberOfHiddenLayers = 3,
    activation = "relu",
    useBias = TRUE,
    dropoutRate = 0.15,
    epochs = 20)
  errors3 = c(errors3, tmp3$Result$MSE_test)
  tmp4 = YinsLibrary::KerasNNRegressor(
    x = X,
    y = y,
    cutoff = 0.97,
    numberOfHiddenLayers = 3,
    activation = "relu",
    useBias = TRUE,
    dropoutRate = 0.15,
    epochs = 20)
  errors4 = c(errors4, tmp4$Result$MSE_test)
} # Done




# # Source
# > YinsLibrary::KerasNNRegressor
# function(
#   x = x,
#   y = y,
#   cutoff = .9,
#   validation_split = 1 - cutoff,
#   loss = 'mae',
#   optimizer = optimizer_rmsprop(),
#   batch_size = 128,
#   activation = 'relu',
#   finalactivation = 'sigmoid',
#   numberOfHiddenLayers = 1,
#   useBias = FALSE,
#   l1.units = 20,
#   l2.units = 10,
#   l3.units = 5,
#   dropoutRate = 0.2,
#   epochs = 10,
#   forceClassifier = FALSE
# ) {
#   
#   # Package
#   library(keras)
#   
#   # Data
#   all <- data.frame(cbind(y, x))
#   
#   # Setup
#   train_idx <- 1:round(cutoff*nrow(all),0)
#   x_train <- as.matrix(all[train_idx, -1])
#   y_train <- as.matrix(all[train_idx, 1])
#   x_test <- as.matrix(all[-train_idx, -1])
#   y_test <- as.matrix(all[-train_idx, 1])
#   
#   # Check levels for response
#   number.of.levels <- nrow(plyr::count(y_train))
#   num_classes <- number.of.levels
#   
#   # To prepare this data for training we one-hot encode the
#   # vectors into binary class matrices using the Keras to_categorical() function
#   # y_train <- to_categorical(y_train, number.of.levels)
#   # y_test <- to_categorical(y_test, number.of.levels)
#   
#   # Defining the Model
#   if (numberOfHiddenLayers == 0) {
#     model <- keras_model_sequential()
#     model %>%
#       layer_dense(
#         units = 1,
#         input_shape = c(ncol(x_train)),
#         activation = finalactivation,
#         use_bias = useBias)
#     summary(model)
#   } else if (numberOfHiddenLayers == 1) {
#     model <- keras_model_sequential()
#     model %>%
#       layer_dense(units = l1.units, activation = activation, input_shape = c(ncol(x_train))) %>%
#       layer_dropout(dropoutRate) %>%
#       layer_dense(units = 1, activation = finalactivation)
#     summary(model)
#   } else if (numberOfHiddenLayers == 2) {
#     model <- keras_model_sequential()
#     model %>%
#       layer_dense(units = l1.units, activation = activation, input_shape = c(ncol(x_train))) %>%
#       layer_dropout(dropoutRate) %>%
#       layer_dense(units = l2.units, activation = activation, use_bias = useBias) %>%
#       layer_dropout(dropoutRate) %>%
#       layer_dense(units = 1, activation = finalactivation)
#     summary(model)
#   } else if (numberOfHiddenLayers == 3) {
#     model <- keras_model_sequential()
#     model %>%
#       layer_dense(units = l1.units, activation = activation, input_shape = c(ncol(x_train))) %>%
#       layer_dropout(dropoutRate) %>%
#       layer_dense(units = l2.units, activation = activation, use_bias = useBias) %>%
#       layer_dropout(dropoutRate) %>%
#       layer_dense(units = l3.units, activation = activation, use_bias = useBias) %>%
#       layer_dropout(dropoutRate) %>%
#       layer_dense(units = 1, activation = finalactivation)
#     summary(model)
#   } else {
#     print("============== WARNING ==============")
#     print("Input value for [numberOfHiddenLayers] must be 0, 1, 2, or 3.")
#     print("Since none of the values above are entered, the default is set to 1.")
#     print("=====================================")
#   } # Done with model
#   
#   
#   # Next, compile the model with appropriate loss function, optimizer, and metrics:
#   model %>% compile(
#     loss = loss,
#     optimizer = optimizer,
#     metrics = c(loss) )
#   
#   # Training and Evaluation
#   history <- model %>% fit(
#     x_train, y_train,
#     epochs = epochs,
#     batch_size = batch_size,
#     validation_split = validation_split
#   ); plot(history)
#   
#   # Evaluate the model's performance on the test data:
#   scores = model %>% evaluate(x_test, y_test)
#   
#   # Generate predictions on new data:
#   if (forceClassifier == TRUE) {
#     y_test_hat <- model %>% predict_proba(x_test)
#     y_test_binary <- ifelse(y_test_hat > mean(y_test_hat), 1, 0)
#     confusion.matrix <- table(Y_Hat = y_test_binary, Y = y_test)
#     test.acc <- sum(diag(confusion.matrix))/sum(confusion.matrix)
#     all.error <- plyr::count(y_test - cbind(y_test_binary))
#     y_test_eval_matrix <- cbind(
#       y_test=y_test,
#       y_test_hat=y_test_binary,
#       y_test_hat_raw=y_test_hat )
#     
#     # AUC/ROC
#     if ((num_classes == 2) && (nrow(plyr::count(y_test_hat)) > 1)) {
#       AUC_test <- pROC::roc(c(y_test), c(y_test_hat))
#     } else {
#       AUC_test <- c("Estimate do not have enough levels.")
#     }
#     
#     # Output
#     result <- list(
#       Confusion.Matrix = confusion.matrix,
#       Confusion.Matrix.Pretty = knitr::kable(confusion.matrix),
#       Testing.Accuracy = test.acc,
#       All.Types.of.Error = all.error,
#       Test_AUC = AUC_test
#     )
#   } else {
#     y_test_hat <- model %>% predict_proba(x_test)
#     MSE_test <- mean((y_test - y_test_hat)^2)
#     y_test_eval_matrix <- cbind(
#       y_test=y_test,
#       y_test_hat_raw=y_test_hat )
#     
#     # Output
#     result <- list(
#       MSE_test = MSE_test
#     )
#   }
#   
#   # Return
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
#       Result = result
#     )
#   )
# }