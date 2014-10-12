# download the zip file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip it to your data directory
# setwd( "your.data.directory" )

power_data <- read.table( "household_power_consumption.txt", sep = ";", header = T )

power_data$Date <- as.Date( strptime( power_data$Date, format = "%d/%m/%Y" ) )

two_days <- subset( power_data, Date == "2007-02-01" | Date == "2007-02-02" )

two_days$Time <- as.character( two_days$Time )

png( file = "plot2.png" )

plot( strptime (paste( as.character( two_days$Date ), two_days$Time ), format = "%Y-%m-%d %H:%M:%S"), as.numeric (as.character(two_days$Global_active_power)), xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

dev.off()

