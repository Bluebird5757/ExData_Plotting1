# Load necessary library
library(data.table)

# Read the data
data <- fread("D:/household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Convert Date to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data for the two days (1st and 2nd February 2007)
subset_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Combine Date and Time into a POSIXct datetime object
subset_data$Datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format = "%Y-%m-%d %H:%M:%S")

# Open the PNG device
png("plot3.png", width = 480, height = 480)

# Plot Sub_metering_1 data
plot(subset_data$Datetime, subset_data$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering", 
     col = "black")

# Add Sub_metering_2 and Sub_metering_3 data to the same plot
lines(subset_data$Datetime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col = "blue")

# Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# Close the device
dev.off()
