# Across the United States, how have emissions from coal combustion-related sources changed from 
# 1999–2008?

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# SCC codes with fuel combustion - coal
codes <- as.character(SCC[grep('Coal', SCC$EI.Sector),1]) 
# subset df with just coal related codes
coal_df <- NEI[NEI$SCC %in% codes, ]

# Create new df of summed emissions and year
sum.coal <- data.frame(
      year = levels(as.factor(coal_df$year)),
      coal_emissions = tapply(coal_df$Emissions, coal_df$year, sum))
# open png device and print the summarised data
png(file='Plot4.png', height=600, width=600)
ggplot(sum.coal, aes(x = year, y = coal_emissions)) + geom_bar(stat = "identity") +
      labs(title="PM2.5 Coal Emissions in the United States [1999-2008]", x="Year", y="Total PM2.5 Emissions in Tons")
dev.off()
# PM2.5 emissions from coal related sources have decreased
