#### Artificial Data ####

# Fake Data
n = 1e3 # train
N = n + 1e3 # size for train + test
cutoff = n/N # ratio for n over N
p = 35 # number of columns I want in the fake data, 6^2 = 36
X = matrix(rnorm(N*p), nrow = N)
y = rbinom(N, 1, 0.5)
all = cbind(y=y, X)
all = cbind(all, 0L) # pad with 0's vector manually if the data doesn't give you a nice rectangle or square shape
dim(X)

# Library
# https://bioconductor.org/packages/release/bioc/html/EBImage.html
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("EBImage")

#### Load Real Data ####

# Real Data
path = "C:/Users/eagle/OneDrive/Course/CU Stats/GRADUATE RESEARCH/PhD Research 2020-9 to 2020-12/Projects/CatsDogs (2016)/data/train"
setwd(path)
list.files()
length(list.files())
EBImage::readImage(list.files()[1])
par(mfrow=c(3,3))
for (i in 1:9) {
  plot(EBImage::resize(EBImage::readImage(list.files()[i]), 128, 128))
}
matrix(EBImage::resize(EBImage::readImage(list.files()[i]), 128, 128))
EBImage::readImage(list.files()[1])
plot(EBImage::readImage(list.files()[1]))
matrix(EBImage::resize(EBImage::readImage(list.files()[1]), 32, 32))
length(matrix(EBImage::resize(EBImage::readImage(list.files()[1]), 32, 32)))

#### Run CNN ####

# Machine Learning: CNN
# this is the type of CNN that is for image classification
tmp = YinsLibrary::KerasC2NN3(
  x = all[, -1],
  y = all[, 1],
  cutoff = cutoff,
  img_rows = 6,
  img_cols = 6,
  epochs = 30 )
tmp$Test_AUC

#### Source ####

# > YinsLibrary::KerasC2NN3
# function(
#   x = all[, -1],
#   y = all[, 1],
#   cutoff = 0.9,
#   img_rows = 4,
#   img_cols = zzz,
#   batch_size = 128,
#   convl1 = 8,
#   convl2 = 8,
#   convl1kernel = c(2,2),
#   convl2kernel = c(2,2),
#   maxpooll1 = c(2,2),
#   activation = 'relu',
#   activationfinal = 'softmax',
#   l1.units = 256,
#   l2.units = 128,
#   l3.units = 64,
#   loss = loss_categorical_crossentropy,
#   optimizer = optimizer_rmsprop(),
#   epochs = 12
# ) {
#   
#   # Package
#   library(keras); library(knitr)
#   
#   # Data Preparation -----------------------------------------------------
#   all <- as.matrix(data.frame(cbind(y, x)))
#   
#   # The data, shuffled and split between train and test sets
#   train_idx <- 1:round(cutoff*nrow(all),0)
#   x_train <- all[train_idx, -1]
#   y_train <- all[train_idx, 1]
#   x_test <- all[-train_idx, -1]
#   y_test <- all[-train_idx, 1]
#   
#   # Redefine  dimension of train/test inputs
#   x_train <- array_reshape(x_train, c(nrow(x_train), img_rows, img_cols, 1))
#   x_test <- array_reshape(x_test, c(nrow(x_test), img_rows, img_cols, 1))
#   input_shape <- c(img_rows, img_cols, 1)
#   #cat('x_train_shape:', dim(x_train), '\n')
#   #cat(nrow(x_train), 'train samples\n')
#   #cat(nrow(x_test), 'test samples\n')
#   
#   # Convert class vectors to binary class matrices
#   num_classes <- nrow(plyr::count(all[,1]))
#   y_train <- to_categorical(y_train, num_classes)
#   y_test <- to_categorical(y_test, num_classes)
#   
#   # Define Model -----------------------------------------------------------
#   model <- keras_model_sequential() %>%
#     layer_conv_2d(filters = convl1, # number of filters
#                   kernel_size = convl1kernel, # the size of the filters
#                   activation = activation, # same with neural network => non-linear component => for general situation in case the assumptions of linearity break
#                   input_shape = input_shape # same with neural network => the only difference is instead of number of variables, we define number of rows and columns in the picture (matrix)
#     ) %>%
#     
#     layer_conv_2d(filters = convl2, kernel_size = convl2kernel, activation = activation) %>%
#     layer_max_pooling_2d(pool_size = maxpooll1) %>% # maxpooling => given a 2x2 matrix, I 'm taking the maximum value => shrink dimension from 2x2=4 to 1 number 
#     layer_dropout(rate = 0.25) %>% # the percentage of data I drop every round of training
#     layer_flatten() %>% # this function is a necessity and it reshapes the output matrices from the previous layer into a big long vector so that we can process neural network
#     layer_dense(units = l1.units, activation = activation) %>% layer_dropout(rate = 0.5) %>%
#     layer_dense(units = l2.units, activation = activation) %>% layer_dropout(rate = 0.5) %>%
#     layer_dense(units = l3.units, activation = activation) %>% layer_dropout(rate = 0.5) %>%
#     layer_dense(units = num_classes, activation = activationfinal)
#   # Compile model
#   model %>% compile(
#     loss = loss,
#     optimizer = optimizer,
#     metrics = c('accuracy')
#   )
#   # Train model
#   history <- model %>% fit(
#     x_train, y_train,
#     batch_size = batch_size,
#     epochs = epochs,
#     validation_split = 0.2 )
#   scores <- model %>% evaluate( x_test, y_test, verbose = 0 )
#   
#   # Generate predictions on new data:
#   y_test_hat <- model %>% predict_classes(x_test)
#   y_test <- as.matrix(all[-train_idx, 1])
#   y_test <- as.numeric(as.character(y_test))
#   confusion.matrix <- table(Y_Hat = y_test_hat, Y = y_test)
#   test.acc <- sum(diag(confusion.matrix))/sum(confusion.matrix)
#   all.error <- plyr::count(as.numeric(as.character(y_test)) - cbind(y_test_hat))
#   
#   # AUC/ROC
#   if ((num_classes == 2) && (nrow(plyr::count(y_test_hat)) > 1)) {
#     AUC_test <- pROC::roc(y_test_hat, c(y_test))
#   } else {
#     AUC_test <- c("Estimate do not have enough levels.")
#   }
#   
#   # Output metrics
#   return(
#     list(
#       Model = list(model = model, scores = scores),
#       Summary = c(
#         paste0('x_train_shape:', dim(x_train), '\n'),
#         paste0(nrow(x_train), 'train samples\n'),
#         paste0(nrow(x_test), 'test samples\n'),
#         paste0('Test loss:', scores[[1]], '\n'),
#         paste0('Test accuracy:', scores[[2]], '\n') ),
#       x_train = x_train,
#       y_train = y_train,
#       x_test = x_test,
#       y_test = y_test,
#       y_test_hat = y_test_hat,
#       Training.Plot = plot(history),
#       Confusion.Matrix = confusion.matrix,
#       Confusion.Matrix.Pretty = knitr::kable(confusion.matrix),
#       Testing.Accuracy = test.acc,
#       All.Types.of.Error = all.error,
#       Test_AUC = AUC_test
#     )
#   )
# }