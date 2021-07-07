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
