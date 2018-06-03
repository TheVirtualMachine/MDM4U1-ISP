# This program creates a CSV file with the data on each respondent's metrics.

source("Calculate.R")

data$purity <- round(data$purity, digits=5)
data$orthodoxy <- round(data$orthodoxy, digits=5)
data <- data[,-4]
write.csv(data, file = "Results.csv")
write.csv(summary(data), file = "Summary.csv")
