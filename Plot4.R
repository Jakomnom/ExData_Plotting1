library(dplyr)

plot_data <- read.table("data/household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)

# Filter before conversion
plot_data_sub <- filter(plot_data, Date == "1/2/2007" | Date == "2/2/2007")

# Convert only necessary rows
plot_data_sub$DateTime <- as.POSIXct(paste(plot_data_sub$Date, plot_data_sub$Time), format="%d/%m/%Y %H:%M:%S")

# Keep only required columns
plot_data_sub <- select(plot_data_sub, DateTime, Global_active_power, Voltage, Global_reactive_power, Sub_metering_1:Sub_metering_3)

# Faster PNG rendering
png(filename="Plot4.png", width=480, height=480, type="cairo")
par(mfrow=c(2, 2))

# Top-left
plot(plot_data_sub$DateTime, plot_data_sub$Global_active_power, type="l", ylab="Global Active Power", xlab="")

# Bottom-left (matplot instead of multiple lines)
matplot(plot_data_sub$DateTime, 
        cbind(plot_data_sub$Sub_metering_1, plot_data_sub$Sub_metering_2, plot_data_sub$Sub_metering_3), 
        type="l", col=c("black", "red", "blue"), lty=1, ylab="Energy sub metering", xlab="")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.8, bty="n")

# Top-right
plot(plot_data_sub$DateTime, plot_data_sub$Voltage, type="l", ylab="Voltage", xlab="datetime")

# Bottom-right
plot(plot_data_sub$DateTime, plot_data_sub$Global_reactive_power, type="l", ylab="Global Reactive Power", xlab="datetime")

dev.off()
