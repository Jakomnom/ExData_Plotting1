
# Create a directory for the data if it doesn't exist
if (!file.exists("data")) {
  dir.create("data")
}

# Download the zip file
download.file(
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",
  destfile = "data/household_power_consumption.zip"
)

# Unzip the file
unzip("data/household_power_consumption.zip", exdir = "data")

# Now read the data
power_data <- read.table("data/household_power_consumption.txt", 
                         header = TRUE, 
                         sep = ";", 
                         na.strings = "?", 
                         dec = ".",
                         stringsAsFactors = FALSE)

# Check the data
head(power_data)

# Convert date and time
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
power_data$Time <- strptime(power_data$Time, format="%H:%M:%S")

# Create the histogram
png("plot1.png", width = 480, height = 480)
hist(power_data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     breaks = 12)  # Adjust number of bins if necessary
dev.off()