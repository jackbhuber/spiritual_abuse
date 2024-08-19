# ESTIMATE RATING SCALE MODEL

# 1. Clear environment
rm(list=ls())

# 2. Prep data
library(readxl) # for reading the source Excel file
#shas <- read_excel("data/data.xlsx") # load Excel file
shas <- read.csv('https://raw.githubusercontent.com/jackbhuber/datasets/main/shas_full_data_set.csv')
all <- shas[ ,14:97] # select items, dems, from columns 14-79
# all <- shas[ ,14:131] # select items through end of Dan's EFA work
# all <- subset(all, select = -c(Ext_Avg:Global_Avg)) # remove columns for now
items <- all[ ,1:66]
items <- read.csv("data/items2.csv")
items <- items[,-1]
items <- items - 1
items2 <- items
source("code/ApplyItemLabels2.R") # items2 gets labels, items doesn't

# 3. Estimate RSM
suppressPackageStartupMessages(library(TAM))
mod_rsm <- TAM::tam.mml(items, irtmodel = "RSM", verbose = FALSE)
mod_rsm2 <- TAM::tam.mml(items2, irtmodel = "RSM", verbose = FALSE)
# summary(rs_model)