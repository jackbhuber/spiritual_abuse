# RATING SCALE STATISTICS AND PLOTS

# LOAD PACKAGES 
library(stats4)
library(lattice)
library(mirt)
library(TAM)
library(readxl) # for reading the source Excel file
library(eRm)
library(pcIRT)
library(ltm)

# PREP DATA
items <- read.csv("data/items2.csv")
items <- items[,-1]
items <- items - 1
# items <- items[complete.cases(items2),]
# items2 <- items2 - 1
items2 <- items
source("code/ApplyItemLabels2.R") # items2 gets labels, items doesn't
source("code/ApplyItemLabels.R")

# ESTIMATE RSM MODELS
model.rsm <- 'SPIRITUAL ABUSE RATING SCALE MODEL = 1-60' # MIRT
mirt_rsm <- mirt(data=items, model=model.rsm, itemtype="rsm", verbose=FALSE) # MIRT
tam_rsm <- TAM::tam.mml(items, irtmodel = "RSM", verbose = FALSE) # TAM
ltm_rsm <- ltm::rasch(items)

# GET ITEM PARAMETERS
mirt_pars <- coef(mirt_rsm, IRTpars=TRUE, simplify=TRUE) # save coefficients
tam_pars <- tam_rsm$xsi # TAM
mirt_pars <- as.data.frame(mirt_pars) # item parameters as data frame
tam_pars <- as.data.frame(tam_pars) # TAM
tam_pars <- tam_pars[1:60, ]
items.tbl <- cbind(mirt_pars,tam_pars)


library(corrplot)
corrplot(cor(items.tbl), order = "original", tl.col='black', tl.cex=.75) # visual correlation matrix

corplot(items.tbl$items.c, items.tbl$xsi)

rm(list=ls())

knitr::kable(items.rsm2, digits = 2, "simple", caption = 'Rating Scale Model Item Parameters for Spiritual Harm and Abuse Items')

# RSM ITEM PLOTS
library(directlabels)
a <- plot(results.rsm, type = 'trace', which.items = 1,
          main = "", par.settings = simpleTheme(lty=1:4,lwd=2),
          auto.key=list(points=FALSE,lines=TRUE, columns=4))
direct.label(a, 'top.points')

# histogram of item difficulties
hist(items.rsm2$c, breaks=50, main = NULL, col="red", xlab="Lifetime Exposure to Spiritual Abuse", xlim = c(-3,3))

# stripchart of item difficulties
# stripchart(items.rsm2$c, xlab = 'Lifetime Exposure to Spiritual Abuse', xlim = c(-3,3), col = 'red', pch = 1, method = 'stack')

plot(results.rsm, type='infotrace', which.item = c(1,2,3,4,5,6), facet_items=T, as.table = TRUE, auto.key=list(points=F, lines=T, columns=1, space = 'right', cex = .8), theta_lim = c(-3, 3), main="")

itemfit(results.rsm, empirical.plot = 2)

# ITEM FIT
ifit <- mirt::itemfit(results.rsm, na.rm=TRUE, 'infit')
i <- as.data.frame(itemfit(results.rsm, na.rm = TRUE, 'infit'))
misfits <- subset(i, outfit > 1.5 | outfit < 0.5 | infit > 1.5 | infit < 0.5)
knitr::kable(misfits, digits = 2, caption = "Rating Scale Model (RSM) - Misfitting Items", row.names = FALSE, "simple")

```{r rsm-item-fit}
knitr::kable(misfits, digits = 2, align = "lcccc", caption = "Rating Scale Model (RSM) - Misfitting Items", row.names = FALSE, "simple")
```
