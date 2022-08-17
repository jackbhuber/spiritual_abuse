# RSM ITEM SEPARATION RELIABILITY

# 1. Clear environment
rm(list=ls())

# 2. Get estimated model data
source("code/IRT-Estimate-RSM.R")
items3 <- items[complete.cases(items),]

# 3. Get item scores
ItemScores <- colSums(items3)

# 4. Get item SD
ItemSD <- apply(items3,2,sd) 

# 5. Calculate the se of the item
ItemSE <- ItemSD/sqrt(length(ItemSD)) # 3. Calculate the se of the Item

# 6. Compute the Observed Variance (also known as Total Person Variability or Squared Standard Deviation)
SSD.ItemScores <- var(ItemScores)

# 7. Compute the Mean Square Measurement error (also known as Model Error variance)
Item.MSE <- sum((ItemSE)^2) / length(ItemSE) 
item.separation.reliability <- (SSD.ItemScores-Item.MSE) / SSD.ItemScores

# 8. Compute item separation reliability
round(item.separation.reliability,2)

# library(eRm)
# 
# # Compute Separation Reliability for a Rasch Model:
# pers <- eRm::person.parameter(RM(items2))
# res <- SepRel(pers)
# res
# summary(res)