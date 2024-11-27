# Load necessary library
library(data.table)
# Read the data
data <- fread("D:/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)
# Subset the data for the two days (assuming dates are '1/2/2007' and '2/2/2007')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
# Open the PNG device
png("plot1.png", width=480, height=480)
# Create the histogram
hist(subset_data$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")

# Close the device
dev.off()