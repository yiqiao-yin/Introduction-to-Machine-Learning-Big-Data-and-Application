#' Trains a LSTM on the IMDB sentiment classification task.
#' 
#' The dataset is actually too small for LSTM to be of any advantage compared to
#' simpler, much faster methods such as TF-IDF + LogReg.
#' 
#' Notes:
#' - RNNs are tricky. Choice of batch size is important, choice of loss and
#'   optimizer is critical, etc. Some configurations won't converge.
#' - LSTM loss decrease patterns during training can be quite different from
#'   what you see with CNNs/MLPs/etc.

library(keras)

max_features <- 20000
batch_size <- 32

# Cut texts after this number of words (among top max_features most common words)
maxlen <- 80  

cat('Loading data...\n')
imdb <- dataset_imdb(num_words = max_features)
# IMDB: movie review dataset 
# X (a paragraph) and y (good or bad, i.e. 0 or 1)
# X (25,000 paragraphs)
# one observation looks like: This movie has great scene. The actors did a great job. The music is awesome. xxxx => Y = 1 (like it)
# I wrote a sentence: I love cats.
# (i) approach: trace the position of the word in your sentence in a dictionary
# Dictionary: [cats, I, love] # this dictionary in practice is a big one that all paragraphs use
# I => [0, 1, 0]
# love => [0, 0, 1]
# cats => [1, 0, 0]
# (ii) approach: trace the index of the word ...
# I => 2
# love => 3
# cats => 1
# I love cats => 2 3 1

x_train <- imdb$train$x
y_train <- imdb$train$y
x_test <- imdb$test$x
y_test <- imdb$test$y
x_train[1,]
dim(x_train)
dim(imdb$train$x)

cat(length(x_train), 'train sequences\n')
cat(length(x_test), 'test sequences\n')

dictionary = keras::dataset_imdb_word_index() # download word index
dictionary = data.frame(unlist(dictionary))
dictionary = data.frame(name = rownames(dictionary), idx = dictionary$unlist.dictionary.) # convert list of dictionary into a dataframe
head(dictionary, 20)
dictionary = dictionary[order(dictionary$idx), ] # order the dictionary with the index
head(dictionary, 20)
dictionary[x_train[1,], ]
dictionary[x_train[1,], 1]
# it looks weird!
# check out another version: https://sanjayasubedi.com.np/deeplearning/word-embeddings-in-keras/

# data clean up process (i'll explain)
cat('Pad sequences (samples x time)\n')
x_train <- pad_sequences(x_train, maxlen = maxlen) # this is to convert x_train into a matrix with a pre-defined max length (this is the number of column) 
x_test <- pad_sequences(x_test, maxlen = maxlen)
cat('x_train shape:', dim(x_train), '\n') # shape = dimension # python: xxx.shape
cat('x_test shape:', dim(x_test), '\n')
dim(x_train)

cat('Build model...\n')
model <- keras_model_sequential()
model %>%
  layer_embedding(input_dim = max_features, output_dim = 128) %>% # note: this is a necessity and it allows us to input our data into a LSTM layer with matching dimensions
  layer_lstm(units = 64, dropout = 0.2, recurrent_dropout = 0.2) %>% # LSTM: long-short term memory
  layer_dense(units = 1, activation = 'sigmoid') # this is technically speaking a regressor (one neuron as output), but it is a predicted probability for class 1, so in the end we convert it into a classification result

# Try using different optimizers and different optimizer configs
model %>% compile(
  loss = 'binary_crossentropy',
  optimizer = 'adam', # empirical knowledge (dont quote me), in some cases ADAM is a slightly more robust optimizer in sequential data
  # recall in gradient descent, we compute partial derivative of the loss function w.r.t. parameters
  # in adam optimizer, we also compute two more partial derivative that is related to the 1st moment and the 2nd moment of the loss function
  metrics = c('accuracy')
)

cat('Train...\n')
model %>% fit(
  x_train, y_train,
  batch_size = batch_size,
  epochs = 15,
  validation_data = list(x_test, y_test)
)

scores <- model %>% evaluate(
  x_test, y_test,
  batch_size = batch_size
)

cat('Test score:', scores[[1]])
cat('Test accuracy', scores[[2]])

dim(x_test)
length(yhat)
yhat <- model %>% predict(x_test)
result = pROC::roc(response = y_test, predictor = c(yhat))
result$auc

head(yhat)
yhat[1]
dictionary[x_test[1,], 1]










# ground truth: y_test
table(y_test)
# educated guess/predictions: yhat
hist(yhat)
tab1 = table(truth=y_test, prediction=as.numeric(yhat > 0.005))
sum(diag(tab1)) / sum(tab1)
# note: we want the diagnoal entries to be large

# Why?
truth = c(rep(1, 10), rep(0, 10))
guess = c(rep(1, 10), rep(1, 10))
table(truth, guess)

# Important practice under imbalanced data set
truth = c(rep(1, 18), rep(0, 2))
guess = c(rep(1, 19), rep(0, 1))
tab2 = table(truth, guess)
sum(diag(tab2)) / sum(tab2)
result = pROC::roc(response = truth, predictor = guess)
# ROC: the curve => the line
# AUC: the area under curve
plot(result)

result = pROC::roc(response = y_test, predictor = c(yhat))
result$auc












