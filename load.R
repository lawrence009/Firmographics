#script to explore firmographic data

require(bit64)
library(data.table)


filelist <- list.files(pattern = '.csv$', full.names = T)

df <- fread(filelist[2], na.strings = '')

head(df[, c('COMMON_CLIENT_ID_SS', 'LOCATION_NUMBER', 'SUBSIDIARY_NUMBER','ULTIMATE_PARENT_NUM')], 25)

#ultimate and workup are Jeff's attempts to explore the infographics
ultimate <- read.csv(filelist[3]) #1904 obs.
workup <- read.csv(filelist[4]) #26358 obs.



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

#Global Customer Master
dt2 <- data.table(read.csv(filelist[1], na.strings = '', as.is = T))
dt2[, CUSTOMER_CREATION_DATE := as.Date(CUSTOMER_CREATION_DATE)]


'
SALES_VOLUME
This field contains an alpha code corresponding to the estimated sales of the business in thousands of dollars.
A         1 - 499
B       500 - 999
C     1,000 - 2,499
D     2,500 - 4,999
E     5,000 - 9,999
F    10,000 - 19,999
G    20,000 - 49,999
H    50,000 - 99,999
I   100,000 - 499,999
J   500,000 - 999,999
K   1,000,000 +
'

#
x <- grepl('^collection', df$PRIMARY_SIC_DESC, ignore.case = T)
y <- grepl('^collection', df$SECONDARY_SIC_DESC, ignore.case = T)

z <- df[x | y, SALES_VOLUME]
table(z)
z <- df[x | y, SIEBEL_ID_PARENT_SS]
length(z)
