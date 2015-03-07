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

# convert to date format
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

# subset to the sample we need
active <- subset(power, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm (power)


library(datasets)

# defining the device to output
png("data/plot1.png", width=480, height=480)

# drawing the histogram
hist(as.numeric(active$Global_active_power), 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.off()
