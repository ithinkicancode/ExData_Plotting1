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

# get the max value from the 3 columns for every row, just so the scale for the graph is correct when overlaying 3 graph lines
max_meterings <- apply ( two_days[, c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")], 1, max )

png( file = "plot4.png" )

par( mfrow = c( 2, 2 ), mar = c( 4, 4, 2, 2) )

#1
plot( time_line, as.numeric (as.character( two_days$Global_active_power)), xlab = "", ylab = "Global Active Power", type = "l" )

#2
plot( time_line, as.numeric (as.character( two_days$Voltage)), xlab = "datetime", ylab = "Voltage", type = "l" )

#3
plot( time_line, max_meterings, type = "n", xlab = "", ylab = "Energy sub metering" )
points( time_line, two_days$Sub_metering_1, type = "l")
points( time_line, two_days$Sub_metering_2, type = "l", col = "red" )
points( time_line, two_days$Sub_metering_3, type = "l", col = "blue" )

legend( "topright", lty = c(1, 1, 1), cex = 0.9, bty = "n", col = c( "black", "red", "blue" ), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

#4
plot( time_line, as.numeric (as.character( two_days$Global_reactive_power)), xlab = "datetime", ylab = "Global_reactive_power", type = "l" )

dev.off()

