library("gtsummary")
library("tidyverse")
library("expss")

all <- read.csv(
  'https://raw.githubusercontent.com/jackbhuber/datasets/main/shas_full_data_set.csv'
)
dems.itms <- as.data.frame(all[, c(80:93, 97)])

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

dems.itms$Gender <- factor(
  dems.itms$Gender,
  levels = c(1, 2, 3, 4, 5, 6),
  labels = c(
    "Cisgender male",
    "Cisgender female",
    "Transgender male",
    "Transgender female",
    "Other",
    "Prefer not to say"
  )
)

dems.itms$"Sexual orientation" <- factor(
  dems.itms$"Sexual orientation",
  levels = c(1, 2, 3, 4, 5, 6),
  labels = c(
    "Straight",
    "Gay/Lesbian",
    "Bisexual",
    "Asexual",
    "Queer",
    "Don\'t know"
  )
)

dems.itms$Race <- factor(
  dems.itms$Race,
  levels = c(1, 2, 3, 4, 5, 6, 7),
  labels = c(
    "Ethnically of Hispanic/Latino Origin",
    "Black/African American",
    "White/European American",
    "Asian",
    "American Indian/Alaska Native",
    "Native Hawaiian/Pacific Islander",
    "Other"
  )
)

dems.itms$"Raised in Christian home" <- ordered(
  dems.itms$"Raised in Christian home",
  levels = c(1, 2),
  labels = c(
    "Yes",
    "No"
  )
)

dems.itms$"Denomination of most abuse" <- factor(
  dems.itms$"Denomination of most abuse",
  levels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17),
  labels = c(
    "Catholic",
    "Charismatic/Pentecostal",
    "Baptist",
    "Mainline",
    "Non-denominational",
    "Orthodox Christian",
    "Mormon",
    "Christian other than above",
    "Evangelistic/Missions organization",
    "College Christian organization",
    "Christian Youth Organization",
    "Christian media company",
    "Christian school or university",
    "Christian political/activist group",
    "Christian aid/social services group",
    "Local Bible study or small group",
    "Christian group other than the above"
  )
)

dems.itms$"Racial makeup of abusive community" <- factor(
  dems.itms$"Racial makeup of abusive community",
  levels = c(1, 2, 3),
  labels = c(
    "Predominantly white", 
    "Mixed race",
    "Predominantly people of color"
  )
)

dems.itms$"Racial makeup of abusive group leadership" <- factor(
  dems.itms$"Racial makeup of abusive group leadership",
  levels = c(1, 2, 3),
  labels = c(
    "Predominantly white", 
    "Mixed race",
    "Predominantly people of color"
  )
)

dems.itms$"Gender makeup of abusive group leadership" <- factor(
  dems.itms$"Gender makeup of abusive group leadership",
  levels = c(1, 2, 3, 4, 5),
  labels = c(
    "All male", 
    "Mostly male", 
    "Mixed gender", 
    "Mostly female", 
    "All female" 
  )
)

dems.itms$"Involvement in abusive group" <- ordered(
  dems.itms$"Involvement in abusive group",
  levels = c(1, 2, 3, 4, 5, 6, 7),
  labels = c(
    "1 - Strongly disagree", 
    "2",
    "3",
    "4",
    "5",
    "6",
    "7 - Strongly agree"
  )
)

dems.itms$"Current religious identification" <- factor(
  dems.itms$"Current religious identification",
  levels = c(1, 2, 3, 4, 5, 6, 7, 8),
  labels = c(
    "Protestant",
    "Catholic",
    "Mormon",
    "Orthodox Christian",
    "Other religious tradition",
    "Atheist",
    "Agnostic",
    "Nothing in particular"
  )
)

dems.itms$"Current theological identification" <- ordered(
  dems.itms$"Current theological identification",
  levels = c(1, 2, 3, 4, 5, 6, 7),
  labels = c(
    "1 - Very conservative",
    "2",
    "3",
    "4 - In the midddle",
    "5",
    "6",
    "7 - Very liberal"
  )
)

dems.itms$"Current view of Bible" <- factor(
  dems.itms$"Current view of Bible",
  levels = c(1, 2, 3),
  labels = c(
    "The Bible is the actual word of God and is to be taken literally, word for word",
    "The Bible is the inspired word of God but not everything should be taken literally, word for word",
    "The Bible is an ancient book of fables, legends, history and moral precepts recorded by man"
  )
)

dems.itms$Generation <- ordered(
  dems.itms$Generation,
  levels = c(1, 2, 3, 4, 5),
  labels = c(
    "1 - Generation (Below age 24)",
    "2 - Generation (Ages 24-39)",
    "3 - Generation (Ages 40-55)",
    "4 - Generation (Ages 56-74)",
    "5 - Generation (Above age 74)"
  )
)

dems.itms$"Podcast Use" <- ordered(
  dems.itms$"Podcast Use",
  levels = c(1, 2, 3),
  labels = c(
    "1 - One episode per week",
    "2 - Two episodes per week",
    "3 - Three or more episodes per week"
  )
)

# dems.itms %>%
#   select(c(
#     "Age",
#     "Gender",
#     "Sexual orientation",
#     "Race",
#     "Raised in Christian home",
#     "Denomination of most abuse",
#     "Racial makeup of abusive community",
#     "Racial makeup of abusive group leadership",
#     "Gender makeup of abusive group leadership",
#     "Involvement in abusive group",
#     "Current religious identification",
#     "Current theological identification",
#     "Current view of Bible",
#     "Generation",
#     "Podcast Use"
#     )) %>%
#   tbl_summary()

dems_table <-
  tbl_summary(
    dems.itms,
    include = c(
      "Age",
      "Generation",
      "Gender",
      "Race",
      "Sexual orientation",
      "Podcast Use"
    ),
    sort = all_categorical(FALSE) ~ "frequency",
  ) |>
  bold_labels()
