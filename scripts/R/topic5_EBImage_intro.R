# PART I: SOFTWARE ENGINEER <= GREAT WORK!

# Install Packge using devtools from below
devtools::install_github("Dr-RAYLI/LisKerasNN")
library(LisKerasNN)
LisKerasNN::LisKerasNN

# PART II: RESEARCH <= IN PROGRESS..
# Clear your mind: what is your question?
# For example: which direction is the car facing?
# the answer to this question can be used in 
# self-driving vehicle!
# The answer is important!
setwd("C:/Users/eagle/Desktop/tesla_car/") # when I am here, there should be two folders: (1) left, (2) right
list.files()
setwd("left/") # label: left
list.files()
tmp = EBImage::readImage("car1.jpg")
# Color: RGB => you have 3 slices of matrix, each of them represent one color
# Each slice is a matrix, what size? 3840 x 2160
plot(tmp)

setwd("C:/Users/eagle/Desktop/tesla_car/") # when I am here, there should be two folders: (1) left, (2) right
setwd("right/") # label: right
list.files()
tmp = EBImage::readImage("car1.jpg")
plot(tmp)


# WHAT IS THE DATA?
# Images:
# Two classes: (1) left, (2) right <= Y to be 1 or 0 (1 means left, and 0 means not left, i.e. right)
# Your Data: matrix <= is generated from pictures
# X

# Workflow:
# X + Y => search for a model => Pass the turing test! (remark: this might be challenging!)
# If you found a model, then go back to Part I and 
# repackage into a function that other people can
# download!