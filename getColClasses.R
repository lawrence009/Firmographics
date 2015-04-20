#returns a vector representing column classes of csv file
getColClasses  <- function(filename, nrows = 10) {
    if(!is.null(filename)) {
        sapply(read.csv(filename, nrows = nrows), class)
    }
}