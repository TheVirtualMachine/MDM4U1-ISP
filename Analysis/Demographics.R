# This program creates bar plots of the respondents broken down by their categorical data.

library(ggplot2)
source("Calculate.R")

makeBarPlot <- function(categoryData, categoryName, categoryTitle) {
	barPlotData <- data[categoryData %in% names(table(categoryData))[table(categoryData) > 1],] # Remove all categorical data points only occurring once, as these data are not helpful for a bar plot.

	# Create the bar plot.
	dataPlot <- ggplot(barPlotData, aes_string(categoryName, fill=categoryName)) # Setup the plot.
	dataPlot <- dataPlot + geom_bar() # Add the bar plot.
	dataPlot <- dataPlot + labs(x = categoryTitle, y = "Count") # Give axes proper labels.
	dataPlot <- dataPlot + theme(legend.position = "none") # Remove the legend.
	ggsave(paste(categoryTitle, "BarPlot.pdf"), plot=dataPlot, width=9, height=8)
}

makeBarPlot(data$grade, "grade", "Grade")
makeBarPlot(data$background, "background", "Ethnic Background")
makeBarPlot(data$stream, "stream", "Stream")
