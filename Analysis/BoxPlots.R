# This program creates box plots of the respondents broken down by their categorical data.

library(ggplot2)
source("Calculate.R")

makeBoxPlot <- function(categoryData, categoryName, categoryTitle) {
	boxPlotData <- data[categoryData %in% names(table(categoryData))[table(categoryData) > 1],] # Remove all categorical data points only occurring once, as these data are not helpful for a box plot.

	# Create the purity plot.
	dataPlot <- ggplot(boxPlotData, aes_string(categoryName, "purity", fill=categoryName), ) # Setup the plot.
	dataPlot <- dataPlot + geom_boxplot() # Add the data points.
	dataPlot <- dataPlot + labs(x = categoryTitle, y = "Purity") # Give axes proper labels.
	dataPlot <- dataPlot + theme(legend.position = "none") # Remove the legend.
	ggsave(paste(categoryTitle, "Purity.pdf"), plot=dataPlot, width=9, height=8)

	# Create the orthodoxy plot.
	dataPlot <- ggplot(boxPlotData, aes_string(categoryName, "orthodoxy", fill=categoryName), ) # Setup the plot.
	dataPlot <- dataPlot + geom_boxplot() # Add the data points.
	dataPlot <- dataPlot + labs(x = categoryTitle, y = "Orthodoxy") # Give axes proper labels.
	dataPlot <- dataPlot + theme(legend.position = "none") # Remove the legend.
	ggsave(paste(categoryTitle, "Orthodoxy.pdf"), plot=dataPlot, width=9, height=8)
}

makeBoxPlot(data$grade, "grade", "Grade")
makeBoxPlot(data$background, "background", "Ethnic Background")
makeBoxPlot(data$stream, "stream", "Stream")
