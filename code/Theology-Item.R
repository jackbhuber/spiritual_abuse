# THEOLOGY ITEM

# 1. Clear environment
rm(list=ls())

# 2. Load packages
library(expss)
library(epiDisplay) 

# 2. Get theology item
all <- read.csv("data/all.csv")
theology <- tab1(all$Q97, 
                 decimal = 1, missing = FALSE,
                 cum.percent = TRUE, graph=FALSE)
theology <- as.data.frame(theology)
theology <- theology[1:7, ]
theology <- theology[,5]
theo <- as.vector(theology)


# # 3. Barplot
# par(mar=c(5,10,5,5))
# barplot(height=theo,
# names=c("1 - Very conservative","2","3","4 - In the middle","5","6","7 - Very liberal"),
# col="red",
# axisnames = TRUE,
# xlab="Percent of Sample",
# xlim=c(0,25),
# horiz=T, las=1)

?barplot


