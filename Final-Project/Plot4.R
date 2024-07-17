library(ggplot2)
library(RColorBrewer)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
str(NEI)
str(SCC)
#4
  png(filename="plot4.png",width=480, height=480)
  SCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
  NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC,]
  totalCoal <- aggregate(Emissions ~ year + type, NEIcoal, sum)
    ggplot(totalCoal, aes(year, Emissions, col = type)) +
    geom_line() +
    geom_point() +
    ggtitle(expression("Total US PM 2.5 Coal Emission")) +
    xlab("Year") +
    ylab("US PM 2.5 Coal Emission") +
    scale_colour_discrete(name = "Type of sources")
  dev.off()
