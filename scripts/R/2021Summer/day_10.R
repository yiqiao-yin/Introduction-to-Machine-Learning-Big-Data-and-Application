#### Linear Regression ####

YinsLibrary::Linear_Regression_Regressor
> YinsLibrary::Linear_Regression_Regressor
function(
  x = all[, -1],
  y = all[, 1],
  cutoff = 0.9,
  cutoff.coefficient = 1) {
  
  # Compile data
  all <- data.frame(cbind(y,x))
  
  # Split data:
  train <- all[1:round(cutoff*nrow(all),0),]; dim(train) # Training set
  test <- all[(round(cutoff*nrow(all),0)+1):nrow(all),]; dim(test) # Testing set
  
  # Identify Response and Explanatory:
  train.x <- data.frame(train[,-1]); colnames(train.x) <- colnames(train)[-1]; dim(train.x)
  train.y <- train[,1]; head(train.y)
  test.x <- data.frame(test[,-1]); dim(test.x)
  test.y <- test[,1]; dim(data.frame(test.y))
  
  # Modeling fitting:
  # GLM or # LM
  model <- lm(
    train.y ~.,
    data = train.x
  )
  sum <- summary(model)
  
  # Make prediction on training:
  preds.train.prob <- predict(model, train.x)
  train.mse <- sum((preds.train.prob - train.y)^2)/nrow(train)
  
  # Make prediction on testing:
  colnames(test.x) <- colnames(train.x)
  preds.prob <- predict(model, test.x)
  test.mse <- sum((preds.prob - test.y)^2)/nrow(test)
  
  # Truth.vs.Predicted.Probabilities
  truth.vs.pred.prob <- cbind(test.y, preds.prob)
  colnames(truth.vs.pred.prob) <- c("True_Test_Y", "Predicted_Test_Y")
  
  # Final output:
  return(
    list(
      Summary = sum,
      Train = train,
      Test = test,
      Train.MSE = train.mse,
      Test.MSE = test.mse,
      Truth_and_Predicted = truth.vs.pred.prob
    )
  )
}

#### Logistic Regression ####

> YinsLibrary::Logistic_Classifier
function(
  x = all[, -1],
  y = all[, 1],
  cutoff = 0.9,
  fam = binomial,
  cutoff.coefficient = 1) {
  
  # Compile data
  all <- data.frame(cbind(y,x))
  
  # Split data:
  train <- all[1:round(cutoff*nrow(all),0),]; dim(train) # Training set
  test <- all[(round(cutoff*nrow(all),0)+1):nrow(all),]; dim(test) # Testing set
  
  # Identify Response and Explanatory:
  train.x <- data.frame(train[,-1]); colnames(train.x) <- colnames(train)[-1]; dim(train.x)
  train.y <- train[,1]; head(train.y)
  test.x <- data.frame(test[,-1]); dim(test.x)
  test.y <- test[,1]; dim(data.frame(test.y))
  
  # Modeling fitting:
  # GLM or # LM
  model <- glm(
    train.y ~.,
    data = train.x,
    family = fam
    # gaussian
    # binomial
    # quasibinomial
  )
  sum <- summary(model)
  
  # Make prediction on training:
  preds.train.prob <- predict(model, train.x)
  preds.mean.train <- mean(preds.train.prob)
  preds.train <- ifelse(preds.train.prob > cutoff.coefficient*preds.mean.train, 1, 0)
  table.train <- as.matrix(cbind(preds.train, train.y))
  tab.train <- table(Y_Hat = table.train[,1], Y = table.train[,2])
  percent.train <- sum(diag(tab.train))/sum(tab.train)
  
  # ROC
  actuals <- train.y
  scores <- preds.train.prob
  roc_obj.train <- pROC::roc(response = actuals, predictor =  scores)
  auc.train <- roc_obj.train$auc
  
  # Make prediction on testing:
  colnames(test.x) <- colnames(train.x)
  preds.prob <- predict(model, test.x) # nrow(test.x)
  preds.mean <- mean(preds.prob)
  preds <- ifelse(preds.prob > cutoff.coefficient*preds.mean, 1, 0)
  table <- as.matrix(cbind(preds, test.y))
  dim(table); head(table)
  
  # Compute accuracy:
  table <- table(Y_Hat = table[,1], Y = table[,2]); table
  percent <- sum(diag(table))/sum(table)
  
  # ROC
  actuals <- test.y
  scores <- preds.prob
  roc_obj <- pROC::roc(response = actuals, predictor =  scores)
  auc <- roc_obj$auc
  
  # Truth.vs.Predicted.Probabilities
  truth.vs.pred.prob <- cbind(test.y, predict(model, test.x))
  colnames(truth.vs.pred.prob) <- c("True Probability", "Predicted Probability")
  
  # Final output:
  return(
    list(
      Summary = sum,
      Training.Accuracy = percent.train,
      Training.AUC = auc.train,
      #Train.ROC = plot(roc_obj.train),
      train.y.hat = preds.train.prob,
      train.y = preds.train.prob,
      test.y.hat = preds,
      test.y.truth = test.y,
      Truth.vs.Predicted.Probabilities = truth.vs.pred.prob,
      Prediction.Table = table,
      Testing.Accuracy = percent,
      Testing.Error = 1 - percent,
      AUC = auc,
      Gini = auc * 2 - 1#,
      #Test.ROC = plot(roc_obj)
    )
  )
}

#### Keras: Neural Network ####

> YinsLibrary::KerasNN
function(
  x = x,
  y = y,
  cutoff = .9,
  validation_split = 1 - cutoff,
  loss = 'categorical_crossentropy',
  optimizer = optimizer_rmsprop(),
  batch_size = 128,
  numberOfLayers = 1,
  activation = 'relu',
  useBias = FALSE,
  finalactivation = 'softmax',
  l1.units = 128,
  l2.units = 64,
  epochs = 30
) {
  
  # Package
  library(keras)
  
  # Data
  all <- data.frame(cbind(y, x))
  
  # Setup
  train_idx <- 1:round(cutoff*nrow(all),0)
  x_train <- as.matrix(all[train_idx, -1])
  y_train <- as.matrix(all[train_idx, 1])
  x_test <- as.matrix(all[-train_idx, -1])
  y_test <- as.matrix(all[-train_idx, 1])
  
  # Check levels for response
  number.of.levels <- nrow(plyr::count(y_train))
  num_classes <- number.of.levels
  
  # To prepare this data for training we one-hot encode the
  # vectors into binary class matrices using the Keras to_categorical() function
  y_train <- to_categorical(y_train, number.of.levels)
  y_test <- to_categorical(y_test, number.of.levels)
  
  # Defining the Model
  if (numberOfLayers == 1) {
    model <- keras_model_sequential()
    model %>%
      layer_dense(
        units = number.of.levels,
        input_shape = c(ncol(x_train)),
        activation = finalactivation,
        use_bias = useBias)
    summary(model)
  } else if (numberOfLayers == 2) {
    model <- keras_model_sequential()
    model %>%
      layer_dense(units = l1.units, activation = activation, use_bias = useBias, input_shape = c(ncol(x_train))) %>%
      layer_dense(units = number.of.levels, use_bias = useBias, activation = finalactivation)
    summary(model)
  } else if (numberOfLayers == 3) {
    model <- keras_model_sequential()
    model %>%
      layer_dense(units = l1.units, activation = activation, use_bias = useBias, input_shape = c(ncol(x_train))) %>%
      layer_dense(units = l2.units, activation = activation, use_bias = useBias) %>%
      layer_dense(units = number.of.levels, use_bias = useBias, activation = finalactivation)
    summary(model)
  } else {
    print("============== WARNING ==============")
    print("Input value for [numberOfLayers] must be 1, 2, or 3.")
    print("Since none of the values above are entered, the default is set to 1.")
    print("=====================================")
    model <- keras_model_sequential()
    model %>%
      layer_dense(
        units = number.of.levels,
        input_shape = c(ncol(x_train)),
        activation = finalactivation,
        use_bias = useBias)
    summary(model)
  }
  
  # Next, compile the model with appropriate loss function, optimizer, and metrics:
  model %>% compile(
    loss = loss,
    optimizer = optimizer,
    metrics = c('accuracy') )
  
  # Training and Evaluation
  history <- model %>% fit(
    x_train, y_train,
    epochs = epochs,
    batch_size = batch_size,
    validation_split = validation_split
  ); plot(history)
  
  # Evaluate the model's performance on the test data:
  scores = model %>% evaluate(x_test, y_test)
  
  # Generate predictions on new data:
  y_test_hat <- model %>% predict_classes(x_test)
  y_test_hat_raw <- model %>% predict_proba(x_test); colnames(y_test_hat_raw) = c(0:(num_classes-1))
  y_test <- as.matrix(all[-train_idx, 1])
  y_test <- as.numeric(as.character(y_test))
  confusion.matrix <- table(Y_Hat = y_test_hat, Y = y_test)
  test.acc <- sum(diag(confusion.matrix))/sum(confusion.matrix)
  all.error <- plyr::count(y_test - cbind(y_test_hat))
  y_test_eval_matrix <- cbind(
    y_test=y_test,
    y_test_hat=y_test_hat,
    y_test_hat_raw=y_test_hat_raw )
  
  # AUC/ROC
  if ((num_classes == 2) && (nrow(plyr::count(y_test_hat)) == 2)) {
    y_test_for_roc = c(y_test)
    y_test_class1_for_roc = c(y_test_hat_raw[, 2])
    AUC_test <- pROC::roc(response = y_test_for_roc, predictor = y_test_class1_for_roc)
  } else {
    print("Estimate do not have enough levels.")
    AUC_test <- 0.5
  }
  
  # Return
  return(
    list(
      Model = list(model = model, scores = scores),
      x_train = x_train,
      y_train = y_train,
      x_test = x_test,
      y_test = y_test,
      y_test_hat = y_test_hat,
      y_test_eval_matrix = y_test_eval_matrix,
      Training.Plot = plot(history),
      Confusion.Matrix = list(regularTable = confusion.matrix, prettyTable = knitr::kable(confusion.matrix)),
      Testing.Accuracy = test.acc,
      All.Types.of.Error = all.error,
      Test_AUC = AUC_test
    )
  )
}

#### Keras: CNN ####

> YinsLibrary::KerasC2NN3
function(
  x = all[, -1],
  y = all[, 1],
  cutoff = 0.9,
  img_rows = 4,
  img_cols = zzz,
  batch_size = 128,
  convl1 = 8,
  convl2 = 8,
  convl1kernel = c(2,2),
  convl2kernel = c(2,2),
  maxpooll1 = c(2,2),
  activation = 'relu',
  activationfinal = 'softmax',
  l1.units = 256,
  l2.units = 128,
  l3.units = 64,
  loss = loss_categorical_crossentropy,
  optimizer = optimizer_adadelta(),
  epochs = 12
) {
  
  # Package
  library(keras); library(knitr)
  
  # Data Preparation -----------------------------------------------------
  all <- as.matrix(data.frame(cbind(y, x)))
  
  # The data, shuffled and split between train and test sets
  train_idx <- 1:round(cutoff*nrow(all),0)
  x_train <- all[train_idx, -1]
  y_train <- all[train_idx, 1]
  x_test <- all[-train_idx, -1]
  y_test <- all[-train_idx, 1]
  
  # Redefine  dimension of train/test inputs
  x_train <- array_reshape(x_train, c(nrow(x_train), img_rows, img_cols, 1))
  x_test <- array_reshape(x_test, c(nrow(x_test), img_rows, img_cols, 1))
  input_shape <- c(img_rows, img_cols, 1)
  #cat('x_train_shape:', dim(x_train), '\n')
  #cat(nrow(x_train), 'train samples\n')
  #cat(nrow(x_test), 'test samples\n')
  
  # Convert class vectors to binary class matrices
  num_classes <- nrow(plyr::count(all[,1]))
  y_train <- to_categorical(y_train, num_classes)
  y_test <- to_categorical(y_test, num_classes)
  
  # Define Model -----------------------------------------------------------
  model <- keras_model_sequential() %>%
    layer_conv_2d(filters = convl1, kernel_size = convl1kernel, activation = activation, input_shape = input_shape) %>%
    layer_conv_2d(filters = convl2, kernel_size = convl2kernel, activation = activation) %>%
    layer_max_pooling_2d(pool_size = maxpooll1) %>% layer_dropout(rate = 0.25) %>%
    layer_flatten() %>%
    layer_dense(units = l1.units, activation = activation) %>% layer_dropout(rate = 0.5) %>%
    layer_dense(units = l2.units, activation = activation) %>% layer_dropout(rate = 0.5) %>%
    layer_dense(units = l3.units, activation = activation) %>% layer_dropout(rate = 0.5) %>%
    layer_dense(units = num_classes, activation = activationfinal)
  # Compile model
  model %>% compile(
    loss = loss,
    optimizer = optimizer,
    metrics = c('accuracy')
  )
  # Train model
  history <- model %>% fit(
    x_train, y_train,
    batch_size = batch_size,
    epochs = epochs,
    validation_split = 0.2 )
  scores <- model %>% evaluate( x_test, y_test, verbose = 0 )
  
  # Generate predictions on new data:
  y_test_hat <- model %>% predict_classes(x_test)
  y_test <- as.matrix(all[-train_idx, 1])
  y_test <- as.numeric(as.character(y_test))
  confusion.matrix <- table(Y_Hat = y_test_hat, Y = y_test)
  test.acc <- sum(diag(confusion.matrix))/sum(confusion.matrix)
  all.error <- plyr::count(as.numeric(as.character(y_test)) - cbind(y_test_hat))
  
  # AUC/ROC
  if ((num_classes == 2) && (nrow(plyr::count(y_test_hat)) > 1)) {
    AUC_test <- pROC::roc(y_test_hat, c(y_test))
  } else {
    AUC_test <- c("Estimate do not have enough levels.")
  }
  
  # Output metrics
  return(
    list(
      Model = list(model = model, scores = scores),
      Summary = c(
        paste0('x_train_shape:', dim(x_train), '\n'),
        paste0(nrow(x_train), 'train samples\n'),
        paste0(nrow(x_test), 'test samples\n'),
        paste0('Test loss:', scores[[1]], '\n'),
        paste0('Test accuracy:', scores[[2]], '\n') ),
      x_train = x_train,
      y_train = y_train,
      x_test = x_test,
      y_test = y_test,
      y_test_hat = y_test_hat,
      Training.Plot = plot(history),
      Confusion.Matrix = confusion.matrix,
      Confusion.Matrix.Pretty = knitr::kable(confusion.matrix),
      Testing.Accuracy = test.acc,
      All.Types.of.Error = all.error,
      Test_AUC = AUC_test
    )
  )
}