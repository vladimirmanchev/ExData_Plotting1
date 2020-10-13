#checks whether the folder "data" exist. If not creates it
if (!file.exists("./data")) {dir.create("./data")}

#downloads the files
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/power consumption.zip")

#reads the data into R
mydf <- read.table(unz("./data/power consumption.zip", "household_power_consumption.txt"), 
                   sep = ";" , na.strings = "?", header = TRUE)

#subsets only the data for dates 2007-02-01 and 2007-02-02
twodaydata<- subset(mydf, Date == "1/2/2007" | Date == "2/2/2007")

#opens PNG device
png(file = "plot1.png")

#plots a histogram of Global active Power
hist(twodaydata$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
#closes the device
dev.off()