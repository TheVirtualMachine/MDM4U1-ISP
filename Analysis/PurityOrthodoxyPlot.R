# This is a program to calculate and plot the orthodoxy score on the sandwich spectrum for all respondents.
# Unless otherwise specified, throughout this file, "sandwich question" refers to a question about either sandwiches or ingredients.

library(ggplot2)
source("Calculate.R")

# Create the plot.
dataPlot <- ggplot(data, aes(purity, orthodoxy)) # Setup the plot.
#dataPlot <- dataPlot + coord_cartesian(ylim = c(-1, 1)) # Set the graph limits.
dataPlot <- dataPlot + geom_point(aes(colour = cat)) # Add the data points.
dataPlot <- dataPlot + geom_smooth(method = loess, level = 0.95, colour = "black", size = 0.5) # Add the confidence curve.
dataPlot <- dataPlot + geom_smooth(method = lm, se = FALSE, colour = "black", size = 0.5, linetype="dashed") # Add the line of best fit.
dataPlot <- dataPlot + labs(x = "Purity", y = "Orthodoxy", colour = "Academic Stream") # Give axes and legend proper labels.
ggsave("PurityVsOrthodoxy.pdf", plot=dataPlot, width=9, height=8)

#results <- rbind(purityScores, orthodoxyScores)
#write.csv(results, "Results.csv")
