# Exploratory Data Analysis
# Made By: Carlos A. Wilson Pérez, 10-Enero-2015

library(data.table)

# Download file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = temp) #destfile="H:/hpc.zip")
hpc <- unzip(temp)

# Get data frame
hpc_data <- read.table(hpc, header=TRUE, na.strings = "?", sep=";")
unlink(temp) 

# Conversion string to date for Date variable.
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")

# Subsetting data frame: from 01/02/2007 to 02/02/2007
hpc_sub <- hpc_data[hpc_data$Date >= as.Date("2007-02-01") & hpc_data$Date <= as.Date("2007-02-02"),]

# Remove data from environment
rm(hpc_data)

# Converting factors to Date objects
datetime <- paste(as.Date(hpc_sub$Date), hpc_sub$Time)
hpc_sub$Datetime <- as.POSIXct(datetime)

#Ploteo a archivo PNG.
# Launch PNG graphics device
png("plot4.png", width=480, height=480, units="px", res=72)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

with(hpc_sub, {
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})

dev.off() 

