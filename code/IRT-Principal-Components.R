# RASCH PRINCIPAL COMPONENTS

# 1. Clear environment
rm(list=ls())

# 2. Get data
pca.data <- read.csv("data/items2.csv")
pca.data <- pca.data[,-1]
pca.data <- pca.data[complete.cases(pca.data),]

# 3. Run principal components
pca <- princomp(pca.data, cor=TRUE)

# EXTRA OPTIONS
# print(pca)
# summary(pca) # print variance accounted for
# loadings(pca) # pc loadings
# pca$scores # the principal components
# biplot(pca)
# fa.parallel(items2)

