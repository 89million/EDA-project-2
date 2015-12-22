### Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
# 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
# subset data for Baltimore City
Bmore <- filter(NEI, fips == '24510')

# Group and summarise baltimore data by year and type
plot_df <- group_by(Bmore, year, type) %>%
      summarise(sum(Emissions))
# rename summed emissions var
names(plot_df)[3] <- "total_emissions"
png(file="Plot3.png", width=600, height=600)
# plot total emissions by year. Fill and facet by source type
ggplot(plot_df, aes(x = as.factor(year), y = total_emissions, fill=type)) + 
      geom_bar(stat = 'identity') + 
      facet_grid(.~type,scales = "free",space="free") + 
      labs(title = "Total Emissions by Source Type in Baltimore City [1999-2008]", x = "Year", y = "Total PM2.5 Emissions in Tons")
dev.off()
# Nonroad, nonpoint and on-road have all decreased. Point emissions have increased.