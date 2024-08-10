# PCA OF RESIDUAL CORRELATIONS

# 1. Clear environment
rm(list=ls())

# 2. Prep data
rasch.prop.var <- read.csv("data/items2.csv")
rasch.prop.var <- rasch.prop.var[ ,-1]
rasch.prop.var <- rasch.prop.var-1 # subtract 1 from all responses to rescale from 0-4
rasch.prop.var[rasch.prop.var == 2] <- 0
rasch.prop.var[rasch.prop.var == 3] <- 1
rasch.prop.var[rasch.prop.var == 4] <- 1
rasch.prop.var <- rasch.prop.var[complete.cases(rasch.prop.var),]

# 3. Estimate the model
library(eRm)
results <- RM(rasch.prop.var)
# summary(results)

# 4. Get residuals
person.locs <- person.parameter(results) # person parameters

# 5. Do PCA on residual correlations
item.fit <- itemfit(person.locs)
std.resids <- item.fit$st.res
pca <- pca(std.resids, nfactors = ncol(rasch.prop.var), rotate = "none")
contrasts <- c(pca$values[1], pca$values[2], pca$values[3], pca$values[4], pca$values[5])