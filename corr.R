corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        files <- list.files(directory)
		    #fileseq <- formatC(id, width = 3, flag = 0)
		    dir <- paste(directory, files, sep="/")
		    #dir1 <- paste(dir,".csv",sep="")
		    dataset <- lapply(dir, function(i) {
            tab <- read.csv(i)
            valid <- na.omit(tab)
            if(nrow(valid) > threshold) {
                cor(valid[,2],valid[,3])
            } else{
                vector('numeric')
            }
        })
	  
        tt <- round(do.call(cbind, dataset),digits=6)
		    #tt <- do.call(rbind,dataset)
        #print(tt)
        as.numeric(tt)
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
}