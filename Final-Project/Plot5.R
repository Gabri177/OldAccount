library(ggplot2)
library(RColorBrewer)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
str(NEI)
str(SCC)
#5
  png(filename="plot5.png",width=480, height=480)
  baltimoreMotor <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
  #baltimoreMotor
  baltimoreMotorSEC <- aggregate(Emissions ~ year, baltimoreMotor, sum)
  #baltimoreMotorAGG
  ggplot(baltimoreMotorSEC, aes(year, Emissions)) +
    geom_line(col = "GREEN") +
    geom_point(col = "RED") +
    ggtitle(expression("Baltimore PM 2.5 Motor Vehicle Emissions")) +
    xlab("Year") +
    ylab("PM 2.5 Motor Vehicle Emissions")
  dev.off()
