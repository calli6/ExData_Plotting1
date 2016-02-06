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


## Plot 2 Global_active_power Thursday-Saturday
plot2.png <- png(filename = "plot2.png",
                 width = 480, height = 480)

plot(x = power$date_time2, y = power$Global_active_power, 
     type = "l",
     xlab = '',
     ylab = "Global Active Power (kilowatts)",
     cex.lab = .75,
     yaxt = 'n')

# Put tick marks on Y axis
y <- c(0,2,4,6)
axis(side = 2, at = y, cex.axis = 0.8)

dev.off()
