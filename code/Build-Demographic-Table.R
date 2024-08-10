# BUILD Characteristic TABLE

# 1. Clear environment
rm(list=ls())

# 2. Get Characteristic data
all <- read.csv("data/all.csv")
all <- all[ ,-1]
dems.itms <- as.data.frame(all[,c(67:81)])
names(dems.itms) <- c(
  Q84 = "Age",
  Q85 = "Gender",
  Q86 = "Sexual orientation",
  Q87 = "Race",
  Q88 = "Raised in Christian home",
  Q89 = "Denomination of most abuse",
  Q90 = "Racial makeup of abusive community",
  Q91 = "Racial makeup of abusive group leadership",
  Q92 = "Gender makeup of abusive group leadership",
  Q95 = "Involvement in abusive group",
  Q93 = "Current religious identification",
  Q97 = "Current theological identification",
  Q98 = "Current view of Bible",
  Generation = "Generation",
  Podcast_Usage = "Podcast Use"
)
suppressPackageStartupMessages(library(expss))
dems.itms = expss::apply_labels(dems.itms,
                                Gender = c("Cisgender Male"=1, "Cisgender Female"=2, "Transgender Male"=3, "Transgender Female"=4, "Other"=5, "Prefer not to say"=6),
                                `Sexual orientation` = c("Straight"=1, "Gay/Lesbian"=2, "Bisexual"=3, "Asexual"=4, "Queer"=5, "Don\'t know"=6),
                                Race= c("Ethnically of Hispanic/Latino Origin"=1, "Black/African American"=2, "White/European American"=3, "Asian"=4, "American Indian/Alaska Native"=5, "Native Hawaiian/Pacific Islander"=6, "Other"=7),
                                `Raised in Christian home` = c("Yes"=1, "No"=2),
                                `Denomination of most abuse` = c("Catholic"=1, "Charismatic/Pentecostal"=2, "Baptist"=3, "Mainline"=4, "Non-denominational"=5, "Orthodox Christian"=6, "Mormon"=7, "Christian other than above"=8, "Evangelistic/Missions organization"=9, "College Christian organization"=10, "Christian Youth Organization"=11, "Christian media company"=12, "Christian school or university"=13, "Christian political/activist group"=14, "Christian aid/social services group"=15, "Local Bible study or small group"=16, "Christian group other than the above"=17),
                                `Current religious identification` = c("Protestant"=1, "Catholic"=2, "Mormon"=3, "Orthodox Christian"=4, "Other religious tradition"=5, "Atheist"=6, "Agnostic"=7, "Nothing in particular"=8),
                                `Current theological identification` = c("1 - Very conservative"=1,"4 - In the midddle"=4,"7 - Very liberal"=7),
                                `Current view of Bible` = c("The Bible is the actual word of God and is to be taken literally, word for word"=1,
                                                            "The Bible is the inspired word of God but not everything should be taken literally, word for word"=2,
                                                            "The Bible is an ancient book of fables, legends, history and moral precepts recorded by man"=3)
)

# 3. Calculate crosstabs for each Characteristic variable
# install.packages('epiDisplay')
library(epiDisplay) 

# GENDER
Gender <- tab1(dems.itms$Gender, decimal = 1, sort.group = "decreasing", cum.percent = FALSE, graph=FALSE)
Gender <- as.data.frame(Gender)
Gender <- Gender[ ,-1]
Gender <- Gender[ ,-3]
names(Gender) <- c("N","%") 
row.names(Gender) <- c("Cisgender Female","Cisgender Male","NA",
                       "Other","Prefer not to say","Transgender Female",
                       "Transgender Male","Total")
#Gender <- cbind(Gender = rownames(Gender), Gender)
#rownames(Gender) <- NULL


# SEXUAL ORIENTATION
SO <- tab1(dems.itms$"Sexual orientation", decimal = 1, sort.group = "decreasing", cum.percent = FALSE, graph=FALSE)
SO <- as.data.frame(SO)
SO <- SO[ ,-1]
SO <- SO[ ,-3]
names(SO) <- c("N","%") 
row.names(SO) <- c("Straight","Bisexual","NA","Gay/Lesbian","Queer","Don\'t know","Asexual","Total")
#SO <- cbind("Sexual Orientation" = rownames(SO), SO)
#rownames(SO) <- NULL

# RACE
race <- tab1(dems.itms$"Race", decimal = 1, sort.group = "decreasing", cum.percent = FALSE, graph=FALSE)
race <- as.data.frame(race)
race <- race[ ,-1]
race <- race[ ,-3]
names(race) <- c("N","%") 
row.names(race) <- c("White/European American",
                   "NA",
                   "Other",
                   "Ethnically of Hispanic/Latin origin",
                   "Black/African American",
                   "Asian",
                   "American Indian / Alaska Native",
                   "Native Hawai'ian / Pacific Islander",
                   "Total")
#race <- cbind(Race = rownames(race), race)
#rownames(race) <- NULL


# RAISED IN CHRISTIAN HOME
Xian <- tab1(dems.itms$"Raised in Christian home", decimal = 1, sort.group = "decreasing", cum.percent = FALSE, graph=FALSE)
Xian <- as.data.frame(Xian)
Xian <- Xian[ ,-1]
Xian <- Xian[ ,-3]
names(Xian) <- c("N","%") 
row.names(Xian) <- c("Yes","No","NA","Total")
#Xian <- cbind("Raised in a Christian home" = rownames(Xian), Xian)
#rownames(Xian) <- NULL


# CURRENT RELIGIOUS IDENTIFICATION
current <- tab1(dems.itms$"Current religious identification", decimal = 1, sort.group = "decreasing", cum.percent = FALSE, graph=FALSE)
current <- as.data.frame(current)
current <- current[ ,-1]
current <- current[ ,-3]
names(current) <- c("N","%") 
row.names(current) <- c("Protestant","Nothing in particular","Agnostic","NA","Atheist",
                     "Orthodox Christian","Catholic","Mormon","Other religious tradition",
                     "Total")
#current <- cbind("Current Religious Identification" = rownames(current), current)
#rownames(current) <- NULL

# CURRENT VIEW OF THE BIBLE
bible <- tab1(dems.itms$"Current view of Bible", decimal = 1, sort.group = "decreasing", cum.percent = FALSE, graph=FALSE)
bible <- as.data.frame(bible)
bible <- bible[ ,-1]
bible <- bible[ ,-3]
names(bible) <- c("N","%") 
row.names(bible) <- c("The Bible is the inspired word of God but not everything should be taken literally, word for word",
                      "The Bible is an ancient book of fables, legends, history and moral precepts recorded by man",
                      "The Bible is the actual word of God and is to be taken literally, word for word",
                      "NA","Total")
#bible <- cbind("Current View of the Bible" = rownames(bible), bible)
#rownames(bible) <- NULL

# AGE
dems.itms$Generation[dems.itms$Age < 25] <- "Gen Z"
dems.itms$Generation[dems.itms$Age > 24 & dems.itms$Age < 41 ] <- "Millennial"
dems.itms$Generation[dems.itms$Age > 40 & dems.itms$Age < 57 ] <- "Gen X"
dems.itms$Generation[dems.itms$Age > 56 & dems.itms$Age < 77 ] <- "Baby Boom"
dems.itms$Generation[dems.itms$Age > 76] <- "Silent Generation"
gen <- tab1(dems.itms$Generation, decimal = 1, sort.group = "decreasing", cum.percent = FALSE, graph=FALSE)
gen <- as.data.frame(gen)
gen <- gen[ ,-1]
gen <- gen[ ,-3]
names(gen) <- c("N","%") 
row.names(gen) <- c("Millennial (Ages 25-40)",
                      "Generation X (Ages 41-56)",
                      "Baby Boom (Ages 57-76)",
                      "Gen Z (Below Age 25)",
                      "Silent Generation (Age 77+)",
                      "NA","Total")

dems.tbl <- rbind(gen,Gender,race,SO)
dems.tbl <- cbind("Characteristic" = rownames(dems.tbl), dems.tbl)
rownames(dems.tbl) <- NULL
dems.tbl$Characteristic[dems.tbl$Characteristic == "NA1"] <- "NA"
dems.tbl$Characteristic[dems.tbl$Characteristic == "NA2"] <- "NA"
dems.tbl$Characteristic[dems.tbl$Characteristic == "NA3"] <- "NA"
dems.tbl$Characteristic[dems.tbl$Characteristic == "Total1"] <- "Total"
dems.tbl$Characteristic[dems.tbl$Characteristic == "Total2"] <- "Total"
dems.tbl$Characteristic[dems.tbl$Characteristic == "Total3"] <- "Total"
dems.tbl$Characteristic[dems.tbl$Characteristic == "Other1"] <- "Other"

christ.tbl <- rbind(Xian,current,bible)
christ.tbl <- cbind("Characteristic" = rownames(christ.tbl), christ.tbl)
rownames(christ.tbl) <- NULL
christ.tbl$Characteristic[christ.tbl$Characteristic == "NA1"] <- "NA"
christ.tbl$Characteristic[christ.tbl$Characteristic == "NA2"] <- "NA"
christ.tbl$Characteristic[christ.tbl$Characteristic == "Total1"] <- "Total"
christ.tbl$Characteristic[christ.tbl$Characteristic == "Total2"] <- "Total"

# 2. Characteristic statistics
# suppressPackageStartupMessages(library(psych))
# dems.tbl <- as.data.frame(describe(dems.itms))
# dems.tbl <- subset(dems.tbl[,-1])
# dems.tbl <- round(dems.tbl,3)
# dems <- subset(dems[-c(16:18),])

