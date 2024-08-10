# RASCH PROPORTION OF VARIANCE

# 1. Clear environment
rm(list=ls())

# 2. Prep data
rasch.prop.var <- read.csv("data/items2.csv")
rasch.prop.var <- rasch.prop.var[,-1]
rasch.prop.var <- rasch.prop.var - 1 # subtract 1 from all responses to rescale from 0-4
rasch.prop.var[rasch.prop.var == 2] <- 0
rasch.prop.var[rasch.prop.var == 3] <- 1
rasch.prop.var[rasch.prop.var == 4] <- 1
rasch.prop.var <- rasch.prop.var[complete.cases(rasch.prop.var),]

# 3. Estimate the model
suppressPackageStartupMessages(library(eRm))
results <- RM(rasch.prop.var)
# summary(results)

# 4. Get residuals
person.locs <- person.parameter(results) # person parameters
model.prob <- pmat(person.locs) # model-predicted probabilities for a correct response for each examinee on each item
responses.without.extremes <- person.locs$X.ex # modified response matrix of no extreme values
resids <- responses.without.extremes - model.prob # residuals = difference between observed responses and model predictions

# 5. Calculate the proportion of variance from the Rasch model

# 5a. Variance of the observations: VO
observations.vector <- as.vector(responses.without.extremes)
VO <- var(observations.vector)

# 5b. Variance of the residuals: VR
residuals.vector <- as.vector(resids)
VR <- var(residuals.vector)

# 5c. Raw variance explained by Rasch measures: (VO - VR)/VO
(VO - VR)/VO