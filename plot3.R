#### Coursera - Exploratory Data Analysis - Week 1 ####
# generate plot3.png
# download data
library(data.table)
temp <- tempfile()
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", temp)
power <- read.delim(unz(temp, "household_power_consumption.txt"),
                   sep = ";", na.strings = "?", header = TRUE, stringsAsFactors = FALSE)
unlink(temp)
rm(temp)

# check the data - confirm dimensions and column names
dim(power) == c(2075259, 9) 
names(power) == c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                  "Voltage", "Global_intensity", 
                  "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# keep data from 2007/02/01-2007/02/02
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- power[power$Date %in% as.Date(c("1/2/2007", "2/2/2007"), "%d/%m/%Y"), ]

# create datetime column
power$datetime <- strptime(paste0(power$Date, power$Time), "%Y-%m-%d %H:%M:%S")

# create plot
png("plot3.png", height = 480, width = 480)
with(power, 
     plot(datetime, Sub_metering_1, type = "n",
          xlab = "", ylab = "Energy sub metering"))
with(power, points(datetime, Sub_metering_1, type = "l"))
with(power, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(power, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue"))

dev.off()

# clean up workspace
rm(power)


