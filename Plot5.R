# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# subset NEI data for Baltimore City

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Bmore <- filter(NEI, fips == '24510')
# search SCC level two for vehile related codes
vehicle.codes <- as.character(SCC[grep('Vehicle', SCC$SCC.Level.Two), 1])
# subset Baltimore data with matching codes
vehicle_df <- Bmore[Bmore$SCC %in% vehicle.codes, ]

sum.vehicle <- data.frame(
      year = levels(as.factor(vehicle_df$year)),
      vehicle_emissions = tapply(vehicle_df$Emissions, vehicle_df$year, sum))
png(file="Plot5.png", height=600, width=600)
ggplot(sum.vehicle, aes(x = year, y = vehicle_emissions)) + geom_bar(stat = "identity") +
      labs(title="PM2.5 Vehicle Emissions in Baltimore City [1999-2008]", y="Total PM2.5 Emissions in Tons", x='Year')
dev.off()
# Emissions from vehicle related sources have declined dramatically