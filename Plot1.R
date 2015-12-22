# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# sum the Emissions column by year
total_e <- tapply(NEI$Emissions, NEI$year, sum)
# open graphic device, print and close dev
png(file = "Plot1.png", height=600, width=600)
barplot(total_e, xlab='Year', ylab="Total PM2.5 Emissions in Tons", 
        main="Total US Emissions by Year [1999-2008]")
dev.off()
# Total Emissions from all sources have decreased.