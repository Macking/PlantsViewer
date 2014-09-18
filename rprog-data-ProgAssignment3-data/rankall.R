rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    ## Check that state and outcome are valid
    if(!(outcome %in% c("heart attack","heart failure","pneumonia")))
        stop("invalid outcome")
    if(!(num == "best" | num == "worst" | !is.na(as.numeric(num))))
        stop("invalid num")
    attackState1 <- subset(data,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack!= "Not Available")
    attackState2 <- subset(attackState1,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure!= "Not Available")
    attackState3 <- subset(attackState2,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia!= "Not Available")
    
    keeps <- c("Hospital.Name","State","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    attack <- attackState3[keeps]
    attack[,3] <- as.numeric(attack[,3])
    attack[,4] <- as.numeric(attack[,4])
    attack[,5] <- as.numeric(attack[,5])
    colnames(attack) <- c("hospital","state","heartattack","heartfailure","pneumonia")
    attack
    
    ## For each state, find the hospital of the given rank
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
}