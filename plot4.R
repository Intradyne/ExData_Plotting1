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
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(5, 4, 2, 2)) # 2x2 of graphs, 5,4,2,2 margins
# 1st plot
plot(DateTime, Raw.Days$Global_active_power, type="l", xlab='', ylab = "Global Active Power")
# 2nd
plot(DateTime, Raw.Days$Voltage, type = "l", ylab = "Voltage")
# 3rd
plot(DateTime, Raw.Days$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(DateTime, Raw.Days$Sub_metering_2, type="l", col="red")
lines(DateTime, Raw.Days$Sub_metering_3, type="l", col="blue")
legend("topright",lty=1, cex=.5,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))
# 4th
plot(DateTime, Raw.Days$Global_reactive_power, type = "l", xlab = "DateTime", ylab = "Global_reactive_voltage")
dev.off() # Export
