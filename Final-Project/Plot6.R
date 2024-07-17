library(ggplot2)
library(RColorBrewer)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
str(NEI)
str(SCC)
#6
  png(filename="plot6.png",width=480, height=480)
  baltLosAngelesMotors <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")
  baltLosAngelesMotorsSEC <- aggregate(Emissions ~ year + fips, baltLosAngelesMotors, sum)
  
  ggplot(baltLosAngelesMotorsSEC, aes(year, Emissions, col = fips)) +
    geom_line() +
    geom_point() +
    ggtitle(expression("Baltimore and Los Angeles PM 2.5 Motor Vehicle Emissions")) +
    labs(x = "Year", y = "PM 2.5 Motor Vehicle Emissions") +
    scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore"))
  dev.off()
