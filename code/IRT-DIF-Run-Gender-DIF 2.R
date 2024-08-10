# GENDER DIF

# 1. Clear environment
rm(list=ls())

# 2. Prep data
suppressPackageStartupMessages(library(lordif))
all <- read.csv("data/all.csv") # get whole data set
dif <- all[,-1] # remove first column
dif <- dif[,-c(5,15,28,33,41,46)] # remove these bad items
# dif <- dif[,1:62] # select 
# dif <- dif[,-61]
gen <- table(dif$Q85) # distribution of gender
barplot(gen, main="Gender", horiz=FALSE, col='red')
gendif <- dif[ which(dif$Q85 == 1 | dif$Q85 == 2), ]
Gender.DIF <- lordif(gendif[,1:60], gendif$Q85, criterion = 'Chisqr', alpha = .01)
# print(Gender.DIF)
# plot(Gender.DIF, labels = c("Cis Male","Cis Female"))


# AGE
# age <- table(dif$Q84) # distribution of age
# barplot(age, main="Age", horiz=FALSE, col='red')
