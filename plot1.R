rm(list=ls())

House <- read.csv('household_power_consumption.txt', sep = ';')
House$Date <- as.Date(House$Date, "%d/%m/%Y")
Data <- House[House$Date == "2007-02-01" | House$Date == "2007-02-02", 1:9]
Data$DateTime <- strptime(paste(as.character(Data$Date), Data$Time), "%Y-%m-%d %H:%M:%S")
Data$Global_active_power <- as.numeric(levels(Data$Global_active_power))[Data$Global_active_power]

png(filename = 'plot1.png', width = 480, height = 480)

hist(Data$Global_active_power, breaks = 12, xlim = c(0,6), ylim = c(0,1200), col = 'red', main ="Global Active Power", xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency')

dev.off()