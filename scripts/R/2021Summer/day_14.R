

# Data
n = 1e3 # train size
N = n + 1e3 # train + test
cutoff = n/N # cutoff
p = 30 # number of parameters / variables
X = data.frame(matrix(rnorm(N*p), N)) # variables
y = ifelse(
  X$X1 > 0,
  ifelse(
    X$X2 > 0.1,
    ifelse(
      X$X3 > 0.2,
      1, 0
    ), 1
  ), 0
)

pairs(cbind(y, X[,1:5]))

# Linear Regression
modelLM = YinsLibrary::Linear_Regression_Regressor(
  x = X, y = y, cutoff = cutoff )
pROC::roc(response = modelLM$Truth_and_Predicted[,1], predictor = modelLM$Truth_and_Predicted[,2])
modelLM$Summary

# Random Forest
modelRF = YinsLibrary::Random_Forest_Classifier(
  x = X,
  y = y,
  cutoff = cutoff,
  num.tree = 20 )
modelRF$Summary

plot(modelRF$Summary)
randomForest::varImpPlot(modelRF$Summary)
# Recall: AUC value, i.e. area-under-curve
# Gini is a function of AUC
modelRF$Summary$importance
modelRF$Summary$test$votes
modelRF$AUC
all = cbind(y=y, X)
par(mfrow=c(1,2))
boxplot(X1~y,data=all)

# Python
# Random Forest Regressor: https://towardsdatascience.com/explaining-feature-importance-by-example-of-a-random-forest-d9166011959e
# Random Forest Classifier: https://towardsdatascience.com/an-implementation-and-explanation-of-the-random-forest-in-python-77bf308a9b76


# Source Code:
# > YinsLibrary::Random_Forest_Classifier
# function(
#   x = all[, -1],
#   y = all[, 1],
#   cutoff = .9,
#   num.tree = 10,
#   num.try = sqrt(ncol(all)),
#   node.size = sqrt(ncol(all)),
#   cutoff.coefficient = 1,
#   SV.cutoff = 1:ncol(all[, -1])
# ) {
#   
#   # Compile data
#   all <- data.frame(cbind(y,x))
#   
#   # Split data:
#   trainIdx <- 1:round(cutoff*nrow(all),0)
#   train <- all[trainIdx, ]; dim(train) # Training set
#   test <- all[-trainIdx, ]; dim(test) # Testing set
#   
#   # Identify Response and Explanatory:
#   train.x <- train[,-1]; dim(train.x)
#   train.y <- train[,1]; head(train.y)
#   test.x <- test[,-1]; dim(test.x)
#   test.y <- test[,1]; dim(data.frame(test.y))
#   
#   # Modeling fitting:
#   model <- randomForest::randomForest(
#     x = as.matrix(train.x),
#     y = as.factor(train.y),
#     xtest = as.matrix(test.x),
#     ytest = as.factor(test.y),
#     ntree = num.tree,
#     mtry = num.try,
#     nodesize = node.size,
#     importance = T,
#     localImp = T)
#   sum <- summary(model)
#   
#   # Extract importance
#   feature.and.score <- data.frame(model$importance)
#   feature.score <- feature.and.score[order(feature.and.score, decreasing = TRUE), ]
#   feature.order <- rownames(feature.and.score)[order(feature.and.score, decreasing = TRUE)]
#   new.feature.and.score <- data.frame(cbind(feature.order, feature.score))
#   head(new.feature.and.score)
#   #SV.cutoff = 1:5
#   selected.variable <- feature.order[SV.cutoff]
#   selected.variable
#   
#   # Make prediction on training:
#   preds.train <- model$predicted
#   preds.train[is.na(preds.train) == TRUE] <- 0
#   #preds.mean.train <- mean(preds.train)
#   #preds.train <- ifelse(preds.train > preds.mean.train, 1, 0)
#   table.train <- as.matrix(cbind(preds.train, train.y))
#   tab.train <- table(Y_Hat = table.train[,1], Y = table.train[,2]); tab.train
#   percent.train <- sum(diag(tab.train))/sum(tab.train); percent.train
#   
#   # ROC
#   actuals <- train.y
#   scores <- as.numeric(preds.train)
#   roc_obj <- pROC::roc(response = actuals, predictor =  scores)
#   auc.train <- roc_obj$auc; auc.train
#   
#   # Make prediction on testing:
#   #preds.binary <- model$test$predicted # colMeans(model$yhat.test)
#   preds.probability <- model$test$votes[,2]
#   preds.mean <- mean(preds.probability)
#   preds.binary <- ifelse(preds.probability > cutoff.coefficient*preds.mean, 1, 0)
#   table <- as.matrix(cbind(preds.binary, test.y)); dim(table); head(table)
#   
#   # Compute accuracy:
#   table <- table(Y_Hat = table[,1], Y = table[,2]); table
#   percent <- sum(diag(table))/sum(table); percent
#   
#   # ROC
#   actuals <- test.y
#   scores <- preds.binary
#   roc_obj <- pROC::roc(response = actuals, predictor =  scores)
#   auc <- roc_obj$auc; auc
#   
#   # Truth.vs.Predicted.Probabilities
#   truth.vs.pred.prob <- cbind(test.y, model$test$votes[,2])
#   colnames(truth.vs.pred.prob) <- c("True Probability", "Predicted Probability")
#   
#   # Final output:
#   return(
#     list(
#       Summary = model,
#       Plot = randomForest::varImpPlot(model),
#       Training.Accuracy = percent.train,
#       Training.AUC = auc.train,
#       Important.Variables = selected.variable,
#       train.y.hat = preds.train,
#       train.y = train,
#       test.y.hat.original = preds.probability,
#       test.y.hat = preds.binary,
#       test.y.truth = test.y,
#       test.y.errors = plyr::count(preds.binary - test.y),
#       Prediction.Table = table,
#       Testing.Accuracy = percent,
#       Testing.Error = 1-percent,
#       AUC = auc,
#       Gini = auc*2 - 1,
#       Truth.vs.Predicted.Probabilities = truth.vs.pred.prob
#     )
#   )
# }