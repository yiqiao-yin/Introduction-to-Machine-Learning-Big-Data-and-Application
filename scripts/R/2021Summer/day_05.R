

# Breast Cancer Data
# In this example, we load data in R.

# (1)
# This is a difficult data set to explore!
setwd("C:/Users/eagle/Desktop/new_folder/data")
data = read.table("breast-cancer.data")
data[1, ]
class(data[1, ])
strsplit(data[1, ], ",") # this can't allow me to extract the actual items in the string
strsplit(data[1, ], ",")[[1]] # extracting the first [[]] and print it # note: this is a list
# the list has 1 entry, and in the entry, it has the items splitted by comma, ","
# in order to extract all the items in not just the list, but the first entry of the list
# we use double bracket, i.e. [[]] # python equivalent: dictionary
class(strsplit(data[1, ], ","))
unlist(strsplit(data[1, ], ",")) # this means break all brackets
# this functions breaks up a string (character) according to a symbol you defined

# (2)
data = read.csv("breast-cancer-data.csv")
head(data, 3)
pairs(data[, c(3, 4, 5)]) # different pairs of scatter plots
as.numeric(as.factor(data[,2]))
plot(data[,4], data[,3], col = as.numeric(as.factor(data[,2])), cex = 2,
     xlab = "texture_mean", ylab = "radius_mean")


# Make sure I have my x and my y
X = data[, -c(1, 2, 33)]
dim(X)
head(X, 2)
y = as.numeric(as.factor(data[,2])) - 1

# Purpose
# Utilize software package
# I 'll walk you through how to build them
beginT = Sys.time()
neuralnetPack = YinsLibrary::KerasNN(
  x = X,
  y = y,
  cutoff = .8)
endT = Sys.time()
print(endT - beginT)
neuralnetPack$Model
neuralnetPack$Test_AUC


# Comment
# 1. Result: 89%
#    check: training the first 80% and testing the last 20%
#    Question: are you okay with the data?
# 2. What can we do with this?
#    discussion: a patient walks into the door, 
#    AI says this person has disease
#    Question: Is this what you want?






