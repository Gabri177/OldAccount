library(ggplot2)
library(RColorBrewer)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
str(NEI)
str(SCC)
#2
png(filename="plot2.png",width=480, height=480)
baltimore <- subset(NEI, NEI$fips == "24510")
totalBaltimore <- aggregate(Emissions ~ year, baltimore, sum)
plot(totalBaltimore$year, totalBaltimore$Emissions, type = "o", 
     main = expression("Total Baltimore PM 2.5 Emissions"), 
     xlab = "Year", ylab = expression("Total Baltimore PM 2.5 Emissions"), col = "Green")
dev.off()
