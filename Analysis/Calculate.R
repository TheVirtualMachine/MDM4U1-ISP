# This is a program to calculate the orthodoxy score on the sandwich spectrum for all respondents.

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
for (i in 1 : NUM_RESPONDENTS) {
	totalResponse <- totalResponse + (sandwichResponses[,i])
}
averageResponse <- totalResponse / NUM_RESPONDENTS # Divide by the number of respondents to find the mean.

orthodoxyScores <- numeric(NUM_RESPONDENTS)
purityScores <- numeric(NUM_RESPONDENTS)

for (i in 1 : NUM_RESPONDENTS) {
	orthodoxyScores[i] <- cosineSimilarity(sandwichResponses[,i], averageResponse)
	purityScores[i] <- sum(sandwichResponses[,i])
}
purityScores <- (purityScores - mean(purityScores)) / sd(purityScores)

# Put data into frame.
data <- data.frame(purity = purityScores, orthodoxy = orthodoxyScores, cat = respondents[,CATEGORY])
