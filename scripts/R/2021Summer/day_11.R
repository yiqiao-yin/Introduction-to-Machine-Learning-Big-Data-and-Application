















tmp = mclust::Mclust(rnorm(10))
tmp$classification

tmp2 = kmeans(rnorm(10), 2)
tmp2$cluster



N = 20
p = 128*128
X = matrix(rnorm(N*p), N, p)
y = rbinom(N, 1, 0.5)
par(mfrow=c(4,4))
sapply(1:16, function(s) plot(EBImage::Image(matrix(X[s,], 128, 128))))

tmp = YinsLibrary::KerasFeatureEngineerVGG16(
  X = X,
  y = y,
  verbatim = TRUE,
  useParallel = TRUE )
tmp$timeConsumption
dim(tmp$data[[1]])
length(tmp$data[[2]])
dim(tmp$newData)

# LIBRARY
library(keras)
K <- backend()

# LOAD MODEL
image = EBImage::Image(EBImage::resize(matrix(X[1,], 6, 6, 3), 224, 224), colormode='Color')
image <- array_reshape(EBImage::resize(matrix(X[1,], 6, 6, 3), 224, 224), dim = c(1, 224, 224, 3))
model_VGG16 <- application_vgg16(weights = "imagenet") # 512
last_conv_layer_VGG16 <- model_VGG16 %>% get_layer("block3_conv1")
iterate <- K$`function`(list(model_VGG16$input), list(last_conv_layer_VGG16$output[1,,,]))
conv_layer_output_value %<-% iterate(list(image))
dim(conv_layer_output_value[[1]])
par(mfrow=c(16, 16))
sapply(1:dim(conv_layer_output_value[[1]])[3], function(plot_i) plot(EBImage::Image(conv_layer_output_value[[1]][,,plot_i])))


# > YinsLibrary::KerasFeatureEngineerVGG16
# function(
#   X = X,
#   y = y,
#   verbatim = TRUE,
#   useParallel = TRUE
# ) {
#   
#   # Library
#   library(keras)
#   K <- backend()
#   
#   # LOAD MODEL
#   model_VGG16 <- application_vgg16(weights = "imagenet") # 512
#   
#   # Parallel:
#   if (useParallel) {
#     # Run BDA Many Times (on multiple cores)
#     result <- list()
#     if (verbatim) {print(paste0("Running Feature Generator now (in parallel) ... ", "Total Number of Rows in Data: ", nrow(X)))}
#     if (verbatim) {print(paste0("... detecting total cores ..."))}
#     ncores <- parallel::detectCores()
#     if (verbatim) {print(paste0("... cores detected, number of cores: ", ncores))}
#     if (verbatim) {print(paste0("... making cluster environment ... "))}
#     cl <- parallel::makeCluster(ncores)
#     if (verbatim) {print(paste0("... setting up parallel environment ..."))}
#     newX = rbind()
#     parallel::clusterExport(cl, c("X", "y", "newX"), envir = environment())
#     parallel::clusterEvalQ(cl=cl, library(YinsLibrary))
#     if (verbatim) {print(paste0("... finished setting up and starting to generate features using VGG16 ..."))}
#     # Time:
#     beginT = Sys.time()
#     system.time({
#       result = pbapply::pblapply(
#         cl = cl,
#         X = 1:nrow(X),
#         FUN = function(i) {
#           # Library
#           library(keras)
#           K <- backend()
#           
#           # LOAD MODEL
#           model_VGG16 <- application_vgg16(weights = "imagenet") # 512
#           
#           # Aggregate Obs
#           curr_img <- EBImage::Image(array(X[i, ], dim = c(224, 224, 3)))
#           curr_img_resized <- EBImage::resize(curr_img, 224, 224)
#           currIMAGE = curr_img_resized
#           image <- keras::array_reshape(currIMAGE, dim = c(1, 224, 224, 3))
#           
#           # POST PREDICTION WORKFLOW
#           # Model: VGG16
#           last_conv_layer_VGG16 <- model_VGG16 %>% get_layer("block5_conv3")
#           iterate <- K$`function`(list(model_VGG16$input), list(last_conv_layer_VGG16$output[1,,,]))
#           conv_layer_output_value %<-% iterate(list(image))
#           currGAPvalue_VGG16 = sapply(1:512, function(kk) {mean(conv_layer_output_value[[1]][,,kk])})
#           
#           # Store Values
#           newX <- rbind(
#             newX,
#             c(currGAPvalue_VGG16)) # end of FUN
#         })
#     }); parallel::stopCluster(cl)
#     result <- do.call(rbind, result)
#     newX = result
#     if (verbatim) {print(paste0("... finished generating features!"))}
#     endT = Sys.time()
#   } else {
#     # LIBRARY
#     library(keras)
#     K <- backend()
#     
#     # LOAD MODEL
#     model_VGG16 <- application_vgg16(weights = "imagenet") # 512
#     
#     # RESHAPE
#     i = 1; newX = rbind()
#     # Time
#     beginT = Sys.time()
#     if (verbatim) {pb <- txtProgressBar(min = 0, max = nrow(X), style = 3)}
#     for (i in 1:nrow(X)) {
#       curr_img <- EBImage::Image(array(X[i, ], dim = c(224, 224, 3)))
#       curr_img_resized <- EBImage::resize(curr_img, 224, 224)
#       currIMAGE = curr_img_resized
#       image <- array_reshape(currIMAGE, dim = c(1, 224, 224, 3))
#       
#       # POST PREDICTION WORKFLOW
#       # Model: VGG16
#       last_conv_layer_VGG16 <- model_VGG16 %>% get_layer("block5_conv3")
#       iterate <- K$`function`(list(model_VGG16$input), list(last_conv_layer_VGG16$output[1,,,]))
#       conv_layer_output_value %<-% iterate(list(image))
#       currGAPvalue_VGG16 = sapply(1:512, function(kk) {mean(conv_layer_output_value[[1]][,,kk])})
#       
#       # Store Values
#       newX <- rbind(
#         newX,
#         c(currGAPvalue_VGG16))
#       
#       # Checkpoint
#       if (verbatim) {setTxtProgressBar(pb, i)}
#     }; if (verbatim) {close(pb); print(paste0("Finished generating features!"))} # Done
#     endT = Sys.time()
#   } # Done
#   
#   # Output
#   return(
#     list(
#       timeConsumption = endT - beginT,
#       data = list(X, y),
#       newData = newX,
#       models = list( model_VGG16 )
#     )
#   )
# }
