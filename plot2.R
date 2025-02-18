# Load required packages
library(data.table)

# Read the data
power_data <- fread("data/household_power_consumption.txt", sep=";", na.strings="?", 
                    colClasses=c("character", "character", rep("numeric", 7)))

# Convert Date column to Date type
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Filter data for the 2-day period
filtered_data <- power_data[Date >= "2007-02-01" & Date <= "2007-02-02"]

# Combine Date and Time columns
filtered_data$DateTime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), 
                                     format="%Y-%m-%d %H:%M:%S")

# Create Plot 2
png("plot2.png", width=480, height=480)
plot(filtered_data$DateTime, filtered_data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
#dev.off()
