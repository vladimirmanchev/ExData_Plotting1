#checks whether the folder "data" exist. If not creates it
if (!file.exists("./data")) {dir.create("./data")}

#downloads the files
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/power consumption.zip")

#loads the necessary packages
library(lubridate)

#reads the data into R
mydf <- read.table(unz("./data/power consumption.zip", "household_power_consumption.txt"), 
                   sep = ";" , na.strings = "?", header = TRUE)

#subsets only the data for dates 2007-02-01 and 2007-02-02
twodaydata<- subset(mydf, Date == "1/2/2007" | Date == "2/2/2007")

#creates a new column by combiuning date and time and transforming them in a POSIXct format
twodaydata$Date_Time<- dmy_hms(paste(twodaydata$Date, twodaydata$Time))

#opens PNG device
png(file = "plot4.png")

#sets the device to plot 4 graphs in a 2 by 2 matrix
par(mfcol=c(2,2), mar=c(4, 4, 2, 2))

#plots a "histogram" of Global active Power over time
with(twodaydata, plot(Global_active_power~Date_Time, type="l",  
                      ylab="Global Active Power", xlab=""))

#plots a "histogram" of Sub metering with different graphs for Sub_metering 1, 2 , and 3
#over time
plot(twodaydata$Sub_metering_1~twodaydata$Date_Time, type="n", ylab="Energy sub metering", 
     xlab="")
points(twodaydata$Sub_metering_1~twodaydata$Date_Time, type="l", col="black")
points(twodaydata$Sub_metering_2~twodaydata$Date_Time, type="l", col="red")
points(twodaydata$Sub_metering_3~twodaydata$Date_Time, type="l", col="blue")
legend("topright", lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), bty = "n")

#plots a "histogram" of Voltage over time
with(twodaydata, plot(Voltage~Date_Time, type="l"))

#plots a "histogram" of Global_reactive_power over time
with(twodaydata, plot(Global_reactive_power~Date_Time, type="l"))

#closes the device
dev.off()