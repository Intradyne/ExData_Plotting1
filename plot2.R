require(data.table, quietly=TRUE, character.only-TRUE) 
# data must be in working directory
# getwd()
File <- "./household_power_consumption.txt"
# First row is
# Date;Time;Global_active_power;Global_reactive_power;Voltage;
# Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# Second row
# 6/10/2010; 08:38:00; 1.412; 0.046; 238.200; 5.800; 0.000; 0.000; 18.000

Raw <- read.table(File, sep = ";", header = TRUE, na.strings = "?") # Reads file into dt
# Now we subset the data to find the two days we are interested in
Raw.Days <- subset(Raw, Raw$Date == "1/2/2007" | Raw$Date == "2/2/2007")
# Format the collumn we want into plotable datetime information
DateTime <- strptime(paste(Raw.Days$Date, Raw.Days$Time), "%d/%m/%Y %H:%M:%S")

# Preparing for export
png("plot2.png", width = 480, height = 480)
# Generate line graph with proper label
plot(DateTime, Raw.Days$Global_active_power, type="l", xlab='', ylab = "Global Active Power (Kilowatts)")
# Export
dev.off()
