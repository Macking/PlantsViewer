rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    ## Check that state and outcome are valid
    statList <- unique(data[,7])
    #statList
    if(!(state %in% statList))
        stop("invalid state")
    if(!(outcome %in% c("heart attack","heart failure","pneumonia")))
        stop("invalid outcome")
    if(!(num == "best" | num == "worst" | !is.na(as.numeric(num))))
        stop("invalid num")
    ## Return hospital name in that state with lowest 30-day death
    data <- subset(data, State == state)
    #data
    if(outcome == "heart attack") {
        keeps <- c("Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
        attack <- data[keeps]
        attackState <- subset(attack,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack!= "Not Available")
        attackState[,2] <- as.numeric(attackState[,2])
        colnames(attackState) <- c("Hospital.Name","Rate")
        if(!is.na(as.numeric(num))) {
            number <- as.numeric(num)
            if(number > nrow(attackState)) {
                return(c(NA))
            } else {
                attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
                OK <- attackState[attackList,]
                return(OK[num,1])
            }
        } else if(num == "best") {
            attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
            OK <- attackState[attackList,]
            return(OK[1,1])
        } else if(num == "worst") {
            attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
            OK <- attackState[attackList,]
            return(OK[nrow(OK),1])
        }
    } else if(outcome == "heart failure") {
        keeps <- c("Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
        attack <- data[keeps]
        attackState <- subset(attack,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure!= "Not Available")
        attackState[,2] <- as.numeric(attackState[,2])
        colnames(attackState) <- c("Hospital.Name","Rate")
        if(!is.na(as.numeric(num))) {
            number <- as.numeric(num)
            if(number > nrow(attackState)) {
                return(c(NA))
            } else {
                attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
                OK <- attackState[attackList,]
                return(OK[num,1])
            }
        } else if(num == "best") {
            attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
            OK <- attackState[attackList,]
            return(OK[1,1])
        } else if(num == "worst") {
            attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
            OK <- attackState[attackList,]
            return(OK[nrow(OK),1])
        }
    } else if(outcome == "pneumonia") {
        keeps <- c("Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
        attack <- data[keeps]
        #colnames(attack) <- c("Hospital.Name","Rate")
        attackState <- subset(attack,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia!= "Not Available")
        attackState[,2] <- as.numeric(attackState[,2])
        colnames(attackState) <- c("Hospital.Name","Rate")
        if(!is.na(as.numeric(num))) {
            number <- as.numeric(num)
            if(number > nrow(attackState)) {
                return(c(NA))
            } else {
                attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
                OK <- attackState[attackList,]
                return(OK[num,1])
            }
        } else if(num == "best") {
            attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
            OK <- attackState[attackList,]
            return(OK[1,1])
        } else if(num == "worst") {
            attackList <- with(attackState,order(attackState$Rate,attackState$Hospital.Name))
            OK <- attackState[attackList,]
            return(OK[nrow(OK),1])
        }
    }
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
}
