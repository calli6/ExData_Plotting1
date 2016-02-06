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

# Plot 1 Frequency of Global_active_power
plot1.png <- png(filename = "plot1.png",
                 width = 480, height = 480)

hist(power$Global_active_power, 
     main = NULL,
     xlab= NULL,
     ylab = NULL,
     col="red", 
     las=0, 
     breaks=12,
     xaxt = 'n',
     yaxt = 'n')

## Create tick marks at points specified
z <- c(0,2,4,6)
y <- c(0,200,400,600,800,1000,1200)
axis(side = 1, at = z, cex.axis = 0.8, tck = -.02)
axis(side = 2, at = y, cex.axis = 0.8)

## Create title and axis labels
title(main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency",
      cex.lab = .75)

dev.off()