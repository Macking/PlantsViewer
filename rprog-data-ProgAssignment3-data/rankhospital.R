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
        #colnames(attack) <- c("Hospital.Name","Rate")
        attack[,2] <- as.numeric(attack[,2])
        if(!is.na(as.numeric(num))) {
            number <- as.numeric(num)
            if(number > nrow(attack)) {
                return(vector('numeric'))
            } else {
                attackState <- attack[order(attack[,2]),]
                
                result <- attackState[1:num,]
                resultMerge <- cbind(result,c(1:num))
                colnames(resultMerge) <- c("Hospital.Name","Rate","Rank")
                resultMerge
            }
        }
        
        
        attackState <- subset(attack,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack!= "Not Available")
        attackState[,3] <- as.numeric(attackState[,3])
        attackState <- attackState[order(attackState[,3]),]
        min <- attackState[1,3]
        reduceTab <- subset(attackState, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == min)
    } else if(outcome == "heart failure") {
        keeps <- c("Hospital.Name","State","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
        attack <- data[keeps]
        attackState <- subset(attack,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure!= "Not Available")
        attackState[,3] <- as.numeric(attackState[,3])
        attackState <- attackState[order(attackState[,3]),]
        min <- attackState[1,3]
        reduceTab <- subset(attackState, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == min)
    } else if(outcome == "pneumonia") {
        keeps <- c("Hospital.Name","State","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
        attack <- data[keeps]
        attackState <- subset(attack,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia!= "Not Available")
        attackState[,3] <- as.numeric(attackState[,3])
        attackState <- attackState[order(attackState[,3]),]
        min <- attackState[1,3]
        reduceTab <- subset(attackState, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <= min)
    }
    rightLine <- reduceTab[order(reduceTab[,2]),]
    hospital <- rightLine[1,1]
    hospital
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
}
