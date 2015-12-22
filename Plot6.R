# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Bmore <- filter(NEI, fips == '24510')
LA <- filter(NEI, fips == '06037')
# combine into single dataframe
LA.Bmore <- rbind(Bmore, LA)
# search level two for vehicle codes
vehicle.codes <- as.character(SCC[grep('Vehicle', SCC$SCC.Level.Two), 1])
# subset rows with matching SCC string
LA.Bmore <- LA.Bmore[LA.Bmore$SCC %in% vehicle.codes, ]
# group and summarise data by year and fips code
plot_df <- group_by(LA.Bmore, year, fips) %>%
      summarise(sum(Emissions))
# rename summed emissions var
names(plot_df)[3] <- "total_emissions"  
# replace fips codes with geographic name
plot_df$fips <- ifelse(plot_df$fips == '06037', "Los Angeles County", "Baltimore City")
# plot total emissions by year. Fill and facet by source type
png(file='Plot6.png', height=600, width=600)
ggplot(plot_df, aes(x = as.factor(year), y = total_emissions, fill=fips)) + 
      geom_bar(stat = 'identity') + 
      facet_grid(.~fips,scales = "free",space="free") + 
      labs(title = "Vehicle Emissions in Baltimore City and Los Angeles County [1999-2008]", x = "Year", y = "Total PM2.5 Emissions in Tons")
dev.off()
# Los Angeles has seen greater nominal changes in vehicle emission activity over the period 1999-2008