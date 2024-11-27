# Load required package
library(data.table)

# Read the data using data.table's fread function
data <- fread("D:/household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Subset the data for the two days (1/2/2007 and 2/2/2007)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- data[(Date == "2007-02-01" | Date == "2007-02-02")]

# Combine Date and Time into a POSIXct datetime object
subset_data$Datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# Open the PNG device
png("plot4.png", width=480, height=480)

# Set up a 2x2 plotting layout
par(mfrow=c(2,2))

# Plot 1: Global Active Power
plot(subset_data$Datetime, subset_data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

# Plot 2: Voltage
plot(subset_data$Datetime, subset_data$Voltage, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

# Plot 3: Energy Sub Metering
plot(subset_data$Datetime, subset_data$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(subset_data$Datetime, subset_data$Sub_metering_2, col="red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1, bty="n")

# Plot 4: Global Reactive Power
plot(subset_data$Datetime, subset_data$Global_reactive_power, 
     type="l", 
     xlab="datetime", 
     ylab="Global Reactive Power")

# Close the PNG device
dev.off()
