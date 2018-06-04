# This program creates a CSV file with the data on each respondent's metrics.

source("Calculate.R")

tableData <- data

tableData$purity <- round(tableData$purity, digits=5)
tableData$orthodoxy <- round(tableData$orthodoxy, digits=5)
tableData <- tableData[,-4]
write.csv(tableData, file = "Results.csv")
write.csv(summary(tableData), file = "Summary.csv")
