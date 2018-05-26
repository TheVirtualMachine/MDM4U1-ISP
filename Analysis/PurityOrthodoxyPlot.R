# This is a program to calculate and plot the orthodoxy score on the sandwich spectrum for all respondents.
# Unless otherwise specified, throughout this file, "sandwich question" refers to a question about either sandwiches or ingredients.

library(ggplot2)
source("Functions.R")

CATEGORY <- 4 # What column the categorical data is in.
QUESTIONS_START <- 6 # What column the sandwich questions start at.
QUESTIONS_END <- 48 # What column the sandwich questions end at.
lockBinding("QUESTIONS_START", globalenv())
lockBinding("QUESTIONS_END", globalenv())

respondents <- read.csv("Responses.csv") # Read in the CSV.
NUM_RESPONDENTS <- nrow(respondents)
lockBinding("NUM_RESPONDENTS", globalenv())

sandwichResponses <- as.matrix(respondents)[,QUESTIONS_START:QUESTIONS_END] # Convert responses to a matrix.
sandwichResponses <- apply(sandwichResponses, 1, as.numeric) # Make the matrix numeric.
sandwichResponses <- 5 - sandwichResponses

NUM_QUESTIONS <- nrow(sandwichResponses) # The number of sandwich questions.
lockBinding("NUM_QUESTIONS", globalenv())

totalResponse <- numeric(NUM_QUESTIONS)
averageResponse <- numeric(NUM_QUESTIONS)

# Sum up the total score for each question by respondent.
for (i in 1:NUM_RESPONDENTS) {
	totalResponse <- totalResponse + (sandwichResponses[,i])
}
averageResponse <- totalResponse / NUM_RESPONDENTS # Divide by the number of respondents to find the mean.

orthodoxyScores <- numeric(NUM_RESPONDENTS)
purityScores <- numeric(NUM_RESPONDENTS)

for (i in 1:NUM_RESPONDENTS) {
	orthodoxyScores[i] <- cosineSimilarity(sandwichResponses[,i], averageResponse)
	purityScores[i] <- sum(sandwichResponses[,i])
}
purityScores <- (purityScores - mean(purityScores)) / sd(purityScores)

# Output the data.
data <- data.frame(purity = purityScores, orthodoxy = orthodoxyScores, cat = respondents[,CATEGORY])

print("Summaries:")
length(which(data$cat == "Academic"))
length(which(data$cat == "Gifted"))
length(which(data$cat == "MaCS"))
print("Purity")
mean(data[which(data$cat == "Academic"),1])
mean(data[which(data$cat == "Gifted"),1])
mean(data[which(data$cat == "MaCS"),1])
mean(data[,1])
print("Orthodoxy")
mean(data[which(data$cat == "Academic"),2])
mean(data[which(data$cat == "Gifted"),2])
mean(data[which(data$cat == "MaCS"),2])
mean(data[,2])
print("End of summaries.")

# Create the plot.
dataPlot <- ggplot(data, aes(purity, orthodoxy)) # Setup the plot.
#dataPlot <- dataPlot + coord_cartesian(ylim = c(-1, 1)) # Set the graph limits.
dataPlot <- dataPlot + geom_point(aes(colour = cat)) # Add the data points.
dataPlot <- dataPlot + geom_smooth(method = loess, level = 0.95, colour = "black", size = 0.5) # Add the confidence curve.
dataPlot <- dataPlot + geom_smooth(method = lm, se = FALSE, colour = "black", size = 0.5, linetype="dashed") # Add the line of best fit.
dataPlot <- dataPlot + labs(x = "Purity", y = "Orthodoxy", colour = "Academic Stream") # Give axes and legend proper labels.
ggsave("PurityVsOrthodoxy.pdf", plot=dataPlot, width=9, height=8)

results <- rbind(purityScores, orthodoxyScores)
write.csv(results, "Results.csv")
