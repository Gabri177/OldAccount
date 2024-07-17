library(ggplot2)
library(RColorBrewer)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
str(NEI)
str(SCC)
#3
png(filename="plot3.png",width=480, height=480)
baltimore <- subset(NEI, NEI$fips == "24510")
#baltimore 
baltimoreType <- aggregate(Emissions ~ year + type, baltimore, sum)
#baltimoreType
ggplot(baltimoreType, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Total Baltimore PM 2.5 Emissions")) +
  ylab("Total Baltimore PM 2.5 Emissions") +
  xlab("Year") +
  scale_colour_discrete(name = "Sources")
  dev.off()
