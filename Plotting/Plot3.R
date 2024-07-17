
library(lubridate)
##read dataa
dato <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

## como lo anterior.
dato$Date <- as.Date(dato$Date, format="%d/%m/%Y")
dato$todo <- paste0(dato$Date, " " , dato$Time)
dato$todo <- as_datetime(dato$todo)
##seleccionar dos dias 
dos <- dato[which(dato$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

## cambiar el tipo de la columna
columna <- grepl("Sub_metering", colnames(dos), fixed=F)
dos[,columna] <- lapply(dos[,columna], function(x) {as.numeric(x)})

##plotting
png(filename="plot3.png", width=480, height = 480 )


with(dos, plot(Sub_metering_1~todo, type='l',col = "black",xlab = "", ylab="Energy sub metering" ))

with(dos, lines(Sub_metering_2~todo,col = "red",xlab = "", ylab="Energy sub metering" ))


with(dos, lines(Sub_metering_3~todo,col = "blue",xlab = "", ylab="Energy sub metering" ))

# adding legend in the right top corner
legend("topright", legend=c(colnames(dos[,columna])), col= c("black", "red", "blue"), lwd = 1, cex=0.75)

dev.off()
