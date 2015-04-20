

df <- read.csv('SS_IG_Data_Appended_03192015.csv')

ultimate <- read.csv('SS_IG_Ultimate_Data.csv')
ultimate$PHONE <- as.numeric(ultimate$PHONE)

ultimate.workup <- read.csv('ULTIMATE_WORK_UP.csv')
