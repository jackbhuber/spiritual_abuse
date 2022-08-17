# Q3 STATISTIC

# 1. Clear environment
rm(list=ls())

# 2. Load data
q3.data <- read.csv("data/items2.csv")
q3.data <- q3.data[ ,-1]
q3.data <- q3.data - 1 # subtract 1 from all responses to rescale from 0-4
q3.data[q3.data == 2] <- 0
q3.data[q3.data == 3] <- 1
q3.data[q3.data == 4] <- 1
q3.data <- q3.data[complete.cases(q3.data),]

# 3. Estimate model
suppressPackageStartupMessages(library(sirt))
mod <- sirt::rasch.mml2(q3.data, progress = FALSE) # estimate the Rasch model
mod.wle <- sirt::wle.rasch(dat=q3.data, b=mod$item$b) # estimate WLEs
mod.q3 <- sirt::Q3(dat=q3.data, theta=mod.wle$theta, b=mod$item$b) # estimate Q3