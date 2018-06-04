# This program creates bar plots of the mean responses of respondents broken down by their categorical data.

library(ggplot2)
source("Calculate.R")

makeMeanPlot <- function(categoryData, categoryName, categoryTitle) {
	orthodoxy <- data$orthodoxy
	cat <- categoryData
	barPlotData <- aggregate(orthodoxy ~ cat, FUN=mean)

	# Create the bar plot.
	dataPlot <- ggplot(barPlotData, aes(x = cat, y = orthodoxy, fill=cat)) # Setup the plot.
	dataPlot <- dataPlot + geom_col() # Add the bar plot.
	dataPlot <- dataPlot + labs(x = categoryTitle, y = "Mean Orthodoxy") # Give axes proper labels.
	dataPlot <- dataPlot + theme(legend.position = "none") # Remove the legend.
	ggsave(paste(categoryTitle, "MeanOrthodoxyPlot.pdf", sep = ""), plot=dataPlot, width=5.5, height=3)

	purity <- data$purity
	cat <- categoryData
	barPlotData <- aggregate(purity ~ cat, FUN=mean)

	# Create the bar plot.
	dataPlot <- ggplot(barPlotData, aes(x = cat, y = purity, fill=cat)) # Setup the plot.
	dataPlot <- dataPlot + geom_col() # Add the bar plot.
	dataPlot <- dataPlot + labs(x = categoryTitle, y = "Mean Purity") # Give axes proper labels.
	dataPlot <- dataPlot + theme(legend.position = "none") # Remove the legend.
	ggsave(paste(categoryTitle, "MeanPurityPlot.pdf", sep = ""), plot=dataPlot, width=5.5, height=3)
}

makeMeanPlot(data$grade, "grade", "Grade")
makeMeanPlot(data$background, "background", "Ethnic Background")
makeMeanPlot(data$stream, "stream", "Stream")
