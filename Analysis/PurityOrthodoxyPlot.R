# This is a program to calculate and plot the orthodoxy score on the sandwich spectrum for all respondents.
# Unless otherwise specified, throughout this file, "sandwich question" refers to a question about either sandwiches or ingredients.

library(data.table)
source("Functions.R")

QUESTIONS_START <- 6 # What column the sandwich questions start at.
QUESTIONS_END <- 48 # What column the sandwich questions end at.
lockBinding("QUESTIONS_START", globalenv())
lockBinding("QUESTIONS_END", globalenv())

respondents <- as.data.table(read.csv("Responses.csv")) # Read in the CSV.
NUM_RESPONDENTS <- nrow(respondents)
lockBinding("NUM_RESPONDENTS", globalenv())

sandwichResponses <- as.matrix(respondents)[,QUESTIONS_START:QUESTIONS_END] # Convert responses to a matrix.
sandwichResponses <- apply(sandwichResponses, 1, as.numeric) # Make the matrix numeric.

NUM_QUESTIONS <- nrow(sandwichResponses) # The number of sandwich questions.
lockBinding("NUM_QUESTIONS", globalenv())


totalResponse <- numeric(NUM_QUESTIONS)
averageResponse <- numeric(NUM_QUESTIONS)

# Sum up the total score for each question by respondent.
for (i in 1:NUM_RESPONDENTS) {
	totalResponse <- totalResponse + (sandwichResponses[,i] - 5)
}
averageResponse <- totalResponse / NUM_RESPONDENTS # Divide by the number of respondents to find the mean.

orthodoxyScores <- numeric(NUM_RESPONDENTS)
purityScores <- numeric(NUM_RESPONDENTS)

for (i in 1:NUM_RESPONDENTS) {
	orthodoxyScores[i] <- cosineSimilarity(sandwichResponses[,i] - 5, averageResponse)
	purityScores[i] <- sum(10 - sandwichResponses[,i])
}

print(orthodoxyScores)
print(purityScores)

lin.mod <- lm(orthodoxyScores ~ purityScores)
lin.mod2 <- lm(orthodoxyScores ~ I(purityScores^2) + purityScores)

pdf("PurityVsOrthodoxy.pdf")
plot(purityScores, orthodoxyScores, xlab="Purity", ylab="Orthodoxy", main="Purity vs Orthodoxy")
invisible(dev.off())

#results <- rbind(purityScores, orthodoxyScores)
#write.csv(results, "Results.csv")
