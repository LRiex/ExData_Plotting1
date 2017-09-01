rm(list=ls())

House <- read.csv('household_power_consumption.txt', sep = ';')
House$Date <- as.Date(House$Date, "%d/%m/%Y")
Data <- House[House$Date == "2007-02-01" | House$Date == "2007-02-02", 1:9]
Data$DateTime <- strptime(paste(as.character(Data$Date), Data$Time), "%Y-%m-%d %H:%M:%S")
Data$Global_active_power <- as.numeric(levels(Data$Global_active_power))[Data$Global_active_power]

png(filename = 'plot2.png', width = 480, height = 480)

with(Data, plot(DateTime, Global_active_power, type = 'l', ylab ='Global Active Power (kilowatts)', xlab = '', axes = FALSE))
axis(side = 2, at = c(0,2,4,6))
axis.POSIXct(side = 1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"),  format = '%a')
box(which = 'plot', lty = 'solid')

dev.off()