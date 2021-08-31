


quantmod::getSymbols("MSFT")
head(MSFT)
MSFT = MSFT[, -5]
MSFT = apply(MSFT, 2, function(c) (c - min(c))/(max(c) - min(c)))
X = as.matrix(as.data.frame(MSFT))[-nrow(MSFT), ]
X = as.matrix(cbind(X,X,X))
y = as.matrix(as.data.frame(MSFT))[-1, ]
cutoff = .5
head(X); head(y)
class(X); class(y)
dim(X); dim(y)

tuneRange = seq(0,500,128)[-1]; tuneRange
for (kk in tuneRange) {
  for (jj in tuneRange) {
    tmp = YinsRLab::KerasNeuralSequenceTranslation(
      X = X,
      y = y,
      cutoff = cutoff,
      validation_split = 1 - cutoff,
      max_len = 3,
      useModel = "lstm",
      num_hidden = 3,
      l1.units = 256,
      l2.units = 128,
      l3.units = 32,
      activation = 'relu',
      loss = 'categorical_crossentropy',
      useDice = TRUE,
      optimizer = optimizer_rmsprop(1e-3),
      batch_size = 128,
      epochs = 40,
      verbatim = TRUE )
  }
} # done

# Plot
y_test = as.ts(tmp$y_test)
yhat_test_mat = as.ts(tmp$yhat_test_mat)
quantmod::chartSeries(MSFT[shortL, ])
testL = (nrow(MSFT) - nrow(as.ts(tmp$y_test)) + 1):nrow(MSFT)
rownames(y_test) <- rownames(MSFT)[testL]
colnames(y_test) = colnames(MSFT)
rownames(yhat_test_mat) = rownames(MSFT)[testL]
colnames(yhat_test_mat) = colnames(MSFT)
shortL = (nrow(y_test)-50):(nrow(y_test))
quantmod::chartSeries(y_test[shortL,])
quantmod::chartSeries(yhat_test_mat[shortL,])


symbols = c("AAPL", "FB", "MSFT", "TSLA")
myList <- list()
myList <- lapply(symbols, function(x) {quantmod::getSymbols(x, from = as.Date("2012-05-18"),  auto.assign = FALSE)})
names(myList) <- symbols
lapply(myList, function(l) nrow(l))

for (i in 1:length(myList)) {
  # i = 1
  xidx = c(1:length(myList))[-i]
  a = xidx[1]
  b = xidx[2]
  c = xidx[3]
  currStock = myList[[i]]
  currStock = currStock[, -5]
  currStock = apply(currStock, 2, function(c) (c - min(c))/(max(c) - min(c)))
  X = as.matrix(as.data.frame(currStock))[-nrow(currStock), ]
  addedX = cbind(
    apply(myList[[a]], 2, function(c) (c - min(c))/(max(c) - min(c)))[-nrow(currStock), -5],
    apply(myList[[b]], 2, function(c) (c - min(c))/(max(c) - min(c)))[-nrow(currStock), -5],
    apply(myList[[c]], 2, function(c) (c - min(c))/(max(c) - min(c)))[-nrow(currStock), -5] )
  X = as.matrix(cbind(X, X, X, addedX))
  y = as.matrix(as.data.frame(currStock))[-1, ]
  cutoff = .95
  
  resultAll = c()
  tuneRange = seq(0,500,128)[-1]; tuneRange
  for (kk in tuneRange) {
    for (jj in tuneRange) {
      tmp = YinsRLab::KerasNeuralSequenceTranslation(
        X = X,
        y = y,
        cutoff = cutoff,
        validation_split = 1 - cutoff,
        max_len = 3,
        useModel = "gru",
        num_hidden = 3,
        l1.units = 128,
        l2.units = 384,
        l3.units = 32,
        activation = 'relu',
        loss = 'categorical_crossentropy',
        useDice = TRUE,
        optimizer = optimizer_rmsprop(1e-3),
        batch_size = 64,
        epochs = 120,
        verbatim = TRUE )
      dim(tmp$y_test); dim(tmp$yhat_test_mat)
      dim(tmp$y_test - tmp$yhat_test_mat)
      print("Checkpoint: MSE is")
      print(mean(apply(as.matrix(tmp$y_test - tmp$yhat_test_mat), 2, function(s) sqrt(mean(s^2)))))
      print(paste0("kk=",kk,"; jj=",jj))
      resultAll = c(
        resultAll,
        paste0(
          "kk=", kk, "; jj=", jj, "; MSE=",
          round(mean(apply(as.matrix(tmp$y_test - tmp$yhat_test_mat), 2, function(s)
            sqrt(mean(s ^ 2)))), 3)))
    }
  } # done
  
  # Plot
  y_test = as.ts(tmp$y_test)
  yhat_test_mat = as.ts(tmp$yhat_test_mat)
  quantmod::chartSeries(MSFT[shortL, ])
  testL = (nrow(MSFT) - nrow(as.ts(tmp$y_test)) + 1):nrow(MSFT)
  rownames(y_test) <- rownames(MSFT)[testL]
  colnames(y_test) = colnames(MSFT)
  rownames(yhat_test_mat) = rownames(MSFT)[testL]
  colnames(yhat_test_mat) = colnames(MSFT)
  shortL = (nrow(y_test)-100):(nrow(y_test))
  quantmod::chartSeries(y_test[shortL,])
  quantmod::chartSeries(yhat_test_mat[shortL,])
}
