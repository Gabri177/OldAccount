library(lubridate)

## read data
dato <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

##crear un nuevo objeto de tiempo que contiene el ano, el mes, la fecha ,la hora, el minuto y el secundo.
dato$Date <- as.Date(dato$Date, format="%d/%m/%Y")
dato$todo <- paste0(dato$Date, " " , dato$Time)
dato$todo<- as_datetime(dato$todo)

## seclecionar las dos especificas dias
dos <- dato[which(dato$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

##cambiar el tipo de la columna
dos$Global_active_power <- as.numeric(dos$Global_active_power)

## plotting
png(filename="plot2.png", width=480, height = 480 )
with(dos, plot(Global_active_power~todo, type='l', xlab = "", ylab="Global Active Power (kilowatts)" ))
dev.off()
