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
png("data/plot2.png", 
    width=480, 
    height=480)

# drawing the graphic
plot(active$DateTime, active$Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()
