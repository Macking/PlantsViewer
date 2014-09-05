pollutantmean <- function(directory, pollutant, id = 1:332) {
	fileseq <- formatC(id, width = 3, flag = 0)
	dir <- paste(directory, fileseq, sep="/")
	dir1 <- paste(dir,".csv",sep="")
	dataset <- lapply(dir1, function(i) {read.csv(i)})
	tt <- do.call(rbind, dataset)
	if(pollutant == "sulfate") {
		round(mean(tt[!is.na(tt[,2]),2]),digits=3)
	} else {
	if(pollutant == "nitrate") {
			round(mean(tt[!is.na(tt[,3]),3]),digits=3)
		}
	}
}