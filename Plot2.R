### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
# subset baltimore data
Bmore <- filter(NEI, fips == '24510')
Bmore_total_e <- tapply(Bmore$Emissions, Bmore$year, sum)
png(file='Plot2.png', height=600, width=600)
barplot(Bmore_total_e, xlab='Year', ylab="Total PM2.5 Emissions in Tons", 
        main="Total Emissions by Year in Baltimore City [1999-2008]")
dev.off()
# Total emissions decreased in 2002 and 2008 but actually incrased in 2005