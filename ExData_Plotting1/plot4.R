## Set working directory
getwd()
setwd("C:/Users/Calli6/Desktop/Exploratory Data Analysis")

## Download zip file and unzip in working directory
dataset_url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir = "power_consumption")

## Read in household_power_consumption
household_power_consumption <- read.csv("C:/Users/Calli6/Desktop/Exploratory Data Analysis/power_consumption/household_power_consumption.txt"
                                        , sep=";"
                                        , stringsAsFactors=FALSE)
## Save dataset as x to shorten name
x <- household_power_consumption
x$Date <- as.Date(x$Date, "%d/%m/%Y")

x$date_time <- paste(x$Date, x$Time)
w <- as.data.frame(strptime(x$date_time, "%Y-%m-%d %H:%M:%S"))
y <- cbind(x, w)
colnames(y)[11] <- "date_time2"

## Select all rows in between 2007-02-01 and 2007-02-02
power <- y[which(y$Date >= '2007-02-01' & y$Date <= '2007-02-02'),]

## Convert Global_active_power to a numeric variable
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
# Get weekdays and hours
power$weekday <- weekdays(power$date_time2, abbreviate = TRUE)

##### Plot 4 (4 plots)
## Figure out how to put 4 graphs into 1 picure

plot4.png <- png(filename = "plot4.png",
                 width = 480, height = 480)
par(mfrow=c(2,2))
# Plot 1 # Global Active Power
plot(power$date_time2, power$Global_active_power, 
     type = "l",
     xlab = '',
     ylab = "Global Active Power (kilowatts)",
     cex.lab = .75,
     yaxt = 'n')
# Put tick marks on Y axis
y <- c(0,2,4,6)
axis(side = 2, at = y, cex.axis = 0.8)

# Plot 2 # Voltage by Date-Time
plot(power$date_time2, power$Voltage, 
     type = "l",
     xlab = 'datetime',
     ylab = "Voltage",
     cex.lab = .75,
     yaxt = 'n')
# Put tick marks on Y axis
y <- c(234,238,242,246)
axis(side = 2, at = y, cex.axis = 0.8)

# Plot 3 Energy sub metering
plot(power$date_time2, power$Sub_metering_1, 
     type = "l",
     xlab = '',
     ylab = "Energy sub metering",
     cex.lab = .75,
     yaxt = 'n')

lines(power$date_time2,power$Sub_metering_2, col = "red")
lines(power$date_time2,power$Sub_metering_3, col = "blue")

# Put tick marks on Y axis
y <- c(0,10,20,30)
axis(side = 2, at = y, cex.axis = 0.8)

# Legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col=c("black","blue","red"), border = "black", lty = c(1,1,1)
       , box.lty = 0
       , xjust = 0, yjust = .50, cex = 1.00,pt.cex= 1.0
       , x.intersp= 1.0, y.intersp = .99
       , adj = 0, inset = .01)

# Plot 4 Global Reactive Power
plot(power$date_time2, power$Global_reactive_power, 
     type = "l",
     xlab = 'datetime',
     ylab = "Global_reactive_power",
     cex.lab = .75,
     yaxt = 'n')
# Put tick marks on Y axis
y <- c(0.0,0.1,0.2,0.3,0.4,0.5)
axis(side = 2, at = y, cex.axis = 0.8)

dev.off()
