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
png("plot2.png", width=480, height=480, units="px", res=72)

# Conversion factor to numeric for Global_active_power variable
hpc_sub$Global_active_power <- as.numeric(as.character(hpc_sub$Global_active_power))

## Generating Plot 2
plot(hpc_sub$Global_active_power ~ hpc_sub$Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off() 