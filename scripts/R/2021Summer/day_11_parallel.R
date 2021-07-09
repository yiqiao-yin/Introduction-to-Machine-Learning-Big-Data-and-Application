#### Parallel Computing ####

# Source: https://github.com/psolymos/pbapply#examples

library(pbapply)
set.seed(1234)
n <- 2000
x <- rnorm(n)
y <- rnorm(n, model.matrix(~x) %*% c(0,1), sd=0.5)
d <- data.frame(y, x)
## model fitting and bootstrap
mod <- lm(y~x, d)
ndat <- model.frame(mod)
B <- 500
bid <- sapply(1:B, function(i) sample(nrow(ndat), nrow(ndat), TRUE))
fun <- function(z) {
  if (missing(z))
    z <- sample(nrow(ndat), nrow(ndat), TRUE)
  coef(lm(mod$call$formula, data=ndat[z,]))
}

## standard '*apply' functions
# system.time(res1 <- lapply(1:B, function(i) fun(bid[,i])))
#    user  system elapsed
#   1.096   0.023   1.127
system.time(res2 <- sapply(1:B, function(i) fun(bid[,i])))
#    user  system elapsed
#   1.152   0.017   1.182
system.time(res3 <- apply(bid, 2, fun))
#    user  system elapsed
#   1.134   0.010   1.160
system.time(res4 <- replicate(B, fun()))
#    user  system elapsed
#   1.141   0.022   1.171

## 'pb*apply' functions
## try different settings:
## "none", "txt", "tk", "win", "timer"
op <- pboptions(type="timer") # default
system.time(res1pb <- pblapply(1:B, function(i) fun(bid[,i])))
#    |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% ~00s
#    user  system elapsed
#   1.539   0.046   1.599
pboptions(op)

pboptions(type="txt")
system.time(res2pb <- pbsapply(1:B, function(i) fun(bid[,i])))
#   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100%
#    user  system elapsed
#   1.433   0.045   1.518
pboptions(op)

pboptions(type="txt", style=1, char="=")
system.time(res3pb <- pbapply(bid, 2, fun))
# ==================================================
#    user  system elapsed
#   1.389   0.032   1.464
pboptions(op)

pboptions(type="txt", char=":")
system.time(res4pb <- pbreplicate(B, fun()))
#   |::::::::::::::::::::::::::::::::::::::::::::::::::| 100%
#    user  system elapsed
#   1.427   0.040   1.481
pboptions(op)
