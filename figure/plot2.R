# Load necessary library
library(data.table)

# Read the data
data <- fread("D:/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

# Subset the data for the two days (assuming dates are '1/2/2007' and '2/2/2007')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Combine Date and Time into a POSIXct datetime object
subset_data$Datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# Open the PNG device
png("plot2.png", width=480, height=480)

# Create the time series plot
plot(subset_data$Datetime, subset_data$Global_active_power, 
     type="l", 
     xlab="",
     ylab="Global Active Power (kilowatts)", 
     col="black")

# Add custom labels for the days
axis(1, at=as.POSIXct(c("2007-02-01", "2007-02-02")), labels=c("Thu", "Fri"))

# Close the device
dev.off()
