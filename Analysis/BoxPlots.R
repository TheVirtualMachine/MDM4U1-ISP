# This program creates box plots of the respondents.

library(ggplot2)
source("Calculate.R")

makeBoxPlot <- function(categoryData, categoryName, categoryTitle) {
	boxPlotData <- data

	# Create the purity plot.
	dataPlot <- ggplot(boxPlotData, aes_string(x = categoryName, y = "purity", fill=categoryName)) # Setup the plot.
	dataPlot <- dataPlot + geom_boxplot() # Add the data points.
	dataPlot <- dataPlot + labs(x = categoryTitle, y = "Purity") # Give axes proper labels.
	dataPlot <- dataPlot + theme(legend.position = "none") # Remove the legend.
	ggsave(paste(categoryTitle, "Purity.pdf", sep = ""), plot=dataPlot, width=5.5, height=5)

	# Create the orthodoxy plot.
	dataPlot <- ggplot(boxPlotData, aes_string(x = categoryName, y = "orthodoxy", fill=categoryName)) # Setup the plot.
	dataPlot <- dataPlot + geom_boxplot() # Add the data points.
	dataPlot <- dataPlot + labs(x = categoryTitle, y = "Orthodoxy") # Give axes proper labels.
	dataPlot <- dataPlot + theme(legend.position = "none") # Remove the legend.
	ggsave(paste(categoryTitle, "Orthodoxy.pdf", sep = ""), plot=dataPlot, width=5.5, height=5)
}

makeBoxPlot(data$grade, "grade", "Grade")
makeBoxPlot(data$background, "background", "Ethnic Background")
makeBoxPlot(data$stream, "stream", "Stream")
makeBoxPlot(data$subjects, "subjects", "Subjects")

boxPlotData <- data

# Create the purity plot.
dataPlot <- ggplot(boxPlotData, aes(x = 1, y = purity)) # Setup the plot.
dataPlot <- dataPlot + geom_boxplot() # Add the data points.
dataPlot <- dataPlot + labs(x = "All respondents", y = "Purity") # Give axes proper labels.
dataPlot <- dataPlot + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) # Remove the x axis.
ggsave("PurityBoxPlot.pdf", plot=dataPlot, width=3, height=5)

# Create the orthodoxy plot.
dataPlot <- ggplot(boxPlotData, aes(x = 1, y = orthodoxy)) # Setup the plot.
dataPlot <- dataPlot + geom_boxplot() # Add the data points.
dataPlot <- dataPlot + labs(x = "All respondents", y = "Orthodoxy") # Give axes proper labels.
dataPlot <- dataPlot + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) # Remove the x axis.
ggsave("OrthodoxyBoxPlot.pdf", plot=dataPlot, width=3, height=5)
