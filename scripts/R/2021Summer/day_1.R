# Addition
a = 3
b = 5
a + b

# Boolean
z = TRUE
z = FALSE
class(z) # class() this is a function to check the format of the object
z*2
as.numeric(z)
1 + "true"
class(1)
class("true")

# Variables
x = 3 # assign x to be 3, x is numerical
class(x)
x = c(1,2,5,6) # c: short for concatenation
class(x)
length(x)
y = c(1,2,c(1,2,3)) # sub-concatenate; different in python
length(y)

# Base Functions
# note: you want to use these when you write 
#       a software program and these functions
#       help you check bugs
is.character("a")
as.character(c(1,2))
class(as.character(c(1,2)))

# Data Frame
a = c(10, 20, 30)
b = c('book', 'paper', 'pen')
tmp1 = data.frame(a, b)
tmp1
class(tmp1)
dim(tmp1)
nrow(tmp1) # this is referring to observation
ncol(tmp1) # this is referring to variables
d = c('b', 'p', 'p')
# note: cbind() <= column bind; you want the # of rows match
#       rbind() <= row bind; you want the # of columns match
cbind(tmp1, d) # column bind
cbind(d, tmp1) # column bind (order is flipped)
dim(tmp1)
length(d)
rbind(tmp1, d) # be aware when this happen
rbind(tmp1, d[1:2]) # row bind;  you want to check code even if there is no bug
rbind(d, tmp1)


tmp2 = data.frame(a, b, d)
tmp2 = data.frame(
  apple = a,
  pear = b,
  orange = d )
colnames(tmp2) = c("C1", "C2", "C5")
colnames(tmp2) = paste0("C", 1:ncol(tmp2))
tmp2

class(tmp2)
dim(tmp2)
ncol(tmp1)
ncol(tmp2)
rbind(tmp1, tmp2)
# define a new variable onto an existing data frame
tmp1$ID = c(4, 5, 6) # when you do data frame $ some name, it will always add to the end
tmp1$ID2 = c(4, 5, 6, 7) # this line will produce an error!!!!
# what is dollar sign?
# Answer: the dollar sign is trying to call the variables
#         the variables are referring to the name of the columns
#         in your data frame
c(10, 20, 30)
c('book', 'paper', 'pen')
tmp3 = data.frame(
  c(10, 20, 30),
  c('book', 'paper', 'pen') )
tmp3$c.10..20..30.
colnames(tmp3)
class(colnames(tmp3))
length(colnames(tmp3))
tmp3$newCol = c(1, 999999999, 999999999)
