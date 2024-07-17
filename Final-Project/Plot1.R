#I've downloaded all the documents necessary to the DIV
getwd()
setwd("C:\Users\dell\Desktop\final")
library(ggplot2)
library(RColorBrewer)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
str(NEI)
str(SCC)
#1
png(filename="plot1.png",width=480, height=480)
totalNEI <- aggregate(Emissions ~ year, NEI, sum)
plot(totalNEI$year, totalNEI$Emissions, type = "o", col = "Green", 
     main = expression("Total US PM 2.5 Emissions"), 
     ylab = expression("Total US PM 2.5 Emissions"), xlab = "Year")
dev.off()
