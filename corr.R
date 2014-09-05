corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

		fileseq <- formatC(id, width = 3, flag = 0)
		dir <- paste(directory, fileseq, sep="/")
		dir1 <- paste(dir,".csv",sep="")
		dataset <- lapply(dir1, function(i) {read.csv(i)})
		tt <- do.call(rbind, dataset)
	
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
}