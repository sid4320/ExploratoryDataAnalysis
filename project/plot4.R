library("data.table")

setwd("C/:Users/sid16/Desktop/Coursera/ExploratoryProject1")

power<- data.table::fread(input = "household_power_consumption.txt"
                          , na.strings="?"
)

power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("Plot_4.png", width=1620, height=720)

par(mfrow=c(2,2))

# First plot
plot(power[, dateTime], power[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Second plot
plot(power[, dateTime],power[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Third plot
plot(power[, dateTime], power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering", col="black")
lines(power[, dateTime], power[, Sub_metering_2], col="red")
lines(power[, dateTime], power[, Sub_metering_3],col="green")
legend("topright", col=c("black","red","green")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 
# Fourth plot
plot(power[, dateTime], power[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()