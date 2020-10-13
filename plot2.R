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
png(file = "plot2.png")

#plots a histogram of Global active Power
with(twodaydata, plot(Global_active_power~Date_Time, type="l",  
                      ylab="Global Active Power (kilowatts)", xlab=""))
#closes the device
dev.off()