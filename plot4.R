rm(list=ls())

House <- read.csv('household_power_consumption.txt', sep = ';')
House$Date <- as.Date(House$Date, "%d/%m/%Y")
Data <- House[House$Date == "2007-02-01" | House$Date == "2007-02-02", 1:9]
Data$DateTime <- strptime(paste(as.character(Data$Date), Data$Time), "%Y-%m-%d %H:%M:%S")

Data$Global_active_power <- as.numeric(levels(Data$Global_active_power))[Data$Global_active_power]
Data$Sub_metering_1 <- as.numeric(levels(Data$Sub_metering_1))[Data$Sub_metering_1]
Data$Sub_metering_2 <- as.numeric(levels(Data$Sub_metering_2))[Data$Sub_metering_2]
Data$Voltage <- as.numeric(levels(Data$Voltage))[Data$Voltage]
Data$Global_reactive_power <- as.numeric(levels(Data$Global_reactive_power))[Data$Global_reactive_power]

png(filename = 'plot4.png', width = 480, height = 480)

par(mfcol = c(2,2))

with(Data, plot(DateTime, Global_active_power, type = 'l', ylab ='Global Active Power (kilowatts)', xlab = '', axes = FALSE))
axis(side = 2, at = c(0,2,4,6))
axis.POSIXct(side = 1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"),  format = '%a')
box(which = 'plot', lty = 'solid')

with(Data, plot(DateTime, Sub_metering_1, type = 'l', ylab ='Energy sub metering', xlab = '', axes = FALSE, col = 'black'))
with(Data, lines(DateTime, Sub_metering_2, col = 'red'))
with(Data, lines(DateTime, Sub_metering_3, col = 'blue'))
axis(side = 2, at = c(0,10,20,30))
axis.POSIXct(side = 1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"),  format = '%a')
box(which = 'plot', lty = 'solid')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = 1, seg.len = 2, col = c('black', 'red', 'blue'))

with(Data, plot(DateTime, Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime', axes = FALSE))
axis(side = 2, at = seq(234, 246, 4))
axis(side = 2, at = seq(234, 246, 2), labels = FALSE)
axis.POSIXct(side = 1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"),  format = '%a')
box(which = 'plot', lty = 'solid')

with(Data, plot(DateTime, Global_reactive_power, type = 'l', ylab = 'Global_reactive_power', xlab = 'datetime', axes = FALSE))
axis(side = 2, at = seq(0.0, 0.5, 0.1))
axis.POSIXct(side = 1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"),  format = '%a')
box(which = 'plot', lty = 'solid')

dev.off()
