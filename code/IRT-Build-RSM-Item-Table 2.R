# BUILD RSM ITEM STATS TABLE

# 1. Clear environment 

# 2. Get estimated model data
source("code/IRT-Estimate-RSM.R")

# 3. Get severity parameters
xsi_rsm <- mod_rsm2$xsi
xsi_rsm <- as.data.frame(xsi_rsm)
xsi_rsm <- xsi_rsm[(1:60), ]
round(xsi_rsm, 2)

# delta_tau_pcm <- mod_pcm$item_irt

# 4. Get fit statistics
fit_rsm <- TAM::tam.fit(mod_rsm2, progress =  FALSE)
fit_rsm <- as.data.frame(fit_rsm[["itemfit"]])
fit_rsm <- fit_rsm[(1:60),-c(1,3,4,5,7,8,9)]
round(fit_rsm,2)

# 5. Identify screening items
screening <- c("*","","","*","","*","","","*","","*","","*","*","","","*","","*","","","","","","","","","","*","","","*","*","*","","","","","*","","","*","","","","","","*","*","*","*","*","*","","*","*","*","*","","*")

# 6. Identify subscales
subscale <- c('controlling leadership',"","",'maintain system',"",'controlling leadership',
              "","",'controlling leadership',"",'controlling leadership',"",'maintain system','maintain system',
              "","",'maintain system',"",'spiritual violence',"","","","","","","","","",'spiritual violence',
              "","",'gender discrimination','controlling leadership','maintain system',"","","","",
              'spiritual violence',"","",'spiritual violence',"","","","","",'internal distress',
              'harmful God-image','internal distress','harmful God-image','internal distress','internal distress',
              "",'internal distress','internal distress','harmful God-image','internal distress',"",
              'internal distress')

# 7. Build items table
items.tbl.rsm <- cbind(subscale, xsi_rsm, fit_rsm)
# items.tbl.rsm <- cbind(screening, subscale, xsi_rsm, fit_rsm)
# items.tbl.rsm <- items.tbl.rsm[,-2]
# items.tbl.rsm <- round(items.tbl.rsm,2)
# items.tbl.rsm$flag <- with(items.tbl.rsm, ifelse(items.tbl.rsm$Infit > 1.5 | items.tbl.rsm$Infit < 0.5 | items.tbl.rsm$Outfit < 0.5 | items.tbl.rsm$Outfit > 1.5, "*", ""))
items.tbl.rsm <- items.tbl.rsm[order(items.tbl.rsm$xsi),]
# remove <- c("Cat1","Cat2","Cat3","Cat4")
# items.tbl.rsm <- items.tbl.rsm[!(row.names(items.tbl.rsm) %in% remove),]