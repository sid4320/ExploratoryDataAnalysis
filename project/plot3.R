library("data.table")

setwd("C/:Users/sid16/Desktop/Coursera/ExploratoryProject1")

power <- data.table::fread(input = "household_power_consumption.txt"
                           , na.strings="?"
)

power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("Plot_3.png", width=640, height=640)

plot(power[, dateTime], power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering", col="green")
lines(power[, dateTime], power[, Sub_metering_2],col="red")
lines(power[, dateTime], power[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("green","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()

