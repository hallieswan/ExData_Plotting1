#### Coursera - Exploratory Data Analysis - Week 1 ####
# generate plot2.png
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

# keep data from 2007-02-01
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- power[power$Date %in% as.Date(c("1/2/2007", "2/2/2007"), "%d/%m/%Y"), ]

# create datetime column
power$datetime <- strptime(paste0(power$Date, power$Time), "%Y-%m-%d %H:%M:%S")

# create plot
png("plot2.png", height = 480, width = 480)
with(power, 
     plot(datetime, Global_active_power, type = "l",
          xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

# clean up workspace
rm(power)


