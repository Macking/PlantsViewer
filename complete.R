complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
		fileseq <- formatC(id, width = 3, flag = 0)
		dir <- paste(directory, fileseq, sep="/")
		dir1 <- paste(dir,".csv",sep="")
		dataset <- lapply(dir1, function(i) {
			tab <- read.csv(i)
			tt <- na.omit(tab)
			count <- length(tt[,1])
			id <- tab[1,4]
			data.frame(id= c(id),nobs=c(count))
			})
		tt <- do.call(rbind, dataset)
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
}