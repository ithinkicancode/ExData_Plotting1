# download the zip file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip it to your data directory
# setwd( "your.data.directory" )

power_data <- read.table( "household_power_consumption.txt", sep = ";", header = T )

power_data$Date <- as.Date( strptime( power_data$Date, format = "%d/%m/%Y" ) )

two_days <- subset ( power_data, Date == "2007-02-01" | Date == "2007-02-02" )

two_days$Time <- as.character( two_days$Time )

time_line <- strptime (paste( as.character( two_days$Date ), two_days$Time ), format = "%Y-%m-%d %H:%M:%S")

two_days$Sub_metering_1 <- as.numeric( as.character( two_days$Sub_metering_1 ) )
two_days$Sub_metering_2 <- as.numeric( as.character( two_days$Sub_metering_2 ) )
two_days$Sub_metering_3 <- as.numeric( as.character( two_days$Sub_metering_3 ) )

max_meterings <- apply ( two_days[, c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")], 1, max )

png( file = "plot3.png" )

plot ( time_line, max_meterings, type = "n", xlab = "", ylab = "Energy sub metering" )
points ( time_line, two_days$Sub_metering_1, type = "l")
points ( time_line, two_days$Sub_metering_2, type = "l", col = "red" )
points ( time_line, two_days$Sub_metering_3, type = "l", col = "blue" )

legend( "topright", lty = c(1, 1, 1), col = c( "black", "red", "blue" ), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

dev.off()

