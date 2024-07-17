
library(lubridate)

## read dato
dato <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

## como lo anterior
dato$Date <- as.Date(dato$Date, format="%d/%m/%Y")
dato$todo <- paste0(dato$Date, " " , dato$Time)
dato$todo <- as_datetime(dato$todo)

## seleccionar dos dias
dos <- dato[which(dato$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

##cambiar el tipo de la columna
columna <- grepl("Sub_metering", colnames(dos), fixed=F)
dos[,columna] <- lapply(dos[,columna], function(x) {as.numeric(x)})

##cambiar el tipo de la columna
columna2 <- grepl("Sub_metering", colnames(dos), fixed=F)
dos[,columna2] <- lapply(dos[,columna2], function(x) {as.numeric(x)})
dos$Voltage <- as.numeric(dos$Voltage)

## plotting
png(filename="plot7.png", width=480, height = 480 )
par(mfrow=c(2,2))

#Global Active power y Weekday-Time
with(dos, plot(Global_active_power~todo, type='l', xlab = "", ylab="Global Active Power (kilowatts)" ))

#Voltage y Weekday-Time
with(dos, plot(Voltage~todo, type='l', xlab = "datetime"))


#Energy submetering y Weekday-time
with(dos, plot(Sub_metering_1~todo, type='l',col = "black",xlab = "", ylab="Energy sub metering" ))
with(dos, lines(Sub_metering_2~todo,col = "red",xlab = "", ylab="Energy sub metering" ))
with(dos, lines(Sub_metering_3~todo, col = "blue",xlab = "", ylab="Energy sub metering" ))

legend("topright", legend=c(colnames(dos[,columna])), bty = "n",col= c("black", "red", "blue"), lwd = 1, cex=0.8)

#Global re-ctive power y Weekday-Time
with(dos, plot(Global_reactive_power~todo, type='l', xlab = "datetime"))



dev.off()
