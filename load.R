#script to explore firmographic data



filelist <- list.files(pattern = '.csv$', full.names = T)

df <- read.csv(filelist[1], na.strings = '')

head(df[, c('COMMON_CLIENT_ID_SS', 'LOCATION_NUMBER', 'SUBSIDIARY_NUMBER','ULTIMATE_PARENT_NUM')], 25)

#ultimate and workup are Jeff's attempts to explore the infographics
ultimate <- read.csv(filelist[2]) #1904 obs.
workup <- read.csv(filelist[3]) #26358 obs.



###
hasLocationNum <- which(!is.na(df$LOCATION_NUMBER)) #25906 obs.
hasUltimateNum <- which(!is.na(df$ULTIMATE_PARENT_NUM)) #9374 obs.
hasSubsidiary <- which(!is.na(df$SUBSIDIARY_NUMBER)) #5605 obs.
uniqueLoc <- order(unique(df$LOCATION_NUMBER[hasLocationNum]))

getDups <- function(df, col = 1) {
    # df is a data frame
    # col is the column number used to check for duplicates
    
    isDup <- duplicated(df[, col])
    dups <- df[, col] %in% df[isDup, col]
    dups <- df[dups, ]
    dups <- dups[order(dups[, col]), ]
}

dups <- getDups(df, 14) #col 14 is LOCATION_NUMBER
