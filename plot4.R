#Download file and put it in data folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="auto")

#unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# converting to a usable table
power <- read.table("data/household_power_consumption.txt", 
                    header=TRUE,
                    sep = ";", 
                    na.strings="?", 
                    dec=".")

# subsampling
sample <- power$Date == "1/2/2007" | power$Date == "2/2/2007"
active <- power[sample, ]


##Converting date and time
dates <- active$Date
times <- active$Time
x <- paste(dates, times)

active$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")


library(datasets)

# defining the device to output
png("data/plot4.png", 
    width=480, 
    height=480)

# defining drawing space

par(mfrow = c(2, 2))

## Top-left graphic
plot(active$DateTime, active$Global_active_power,
     type = "l",
     xlab = "", 
     ylab = "Global Active Power")

## Top-right graphic
plot(active$DateTime, active$Voltage,
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage")

## Bottom-left graphic
plot(active$DateTime, active$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering")

lines(active$DateTime, active$Sub_metering_2, 
      col = "red")

lines(active$DateTime, active$Sub_metering_3, 
      col = "blue")

legend("topright",
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

## Bottom-right graphic
plot(active$DateTime, active$Global_reactive_power,
     type = "l",
     col = "black",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
