
#This script will create a line chart with multiple data series
#and save a png file into the working directory

#Download Data
originalURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destnURL <- "exdata-data-household_power_consumption.zip"
download.file(originalURL, destfile = destnURL)
unzip(destnURL)

#Read data for the graphs.
#The dataset has 2,075,259 rows and 9 columns, so it will take a while to load
FullDF <- read.csv("household_power_consumption.txt",sep=';', na.strings="?")
FullDF[["Date"]] <- as.Date(FullDF[["Date"]], format="%d/%m/%Y")

#Getting what we need for this project
#Data from the dates 2007-02-01 and 2007-02-02
ReqData <- subset(FullDF, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))



#Converting Day and Time series for x axis
Date_Time <- paste(ReqData[["Date"]], ReqData[["Time"]])
Day <- as.POSIXct(Date_Time)

#Plot 3
with(ReqData, {
  plot(ReqData[["Sub_metering_1"]]~Day, type="l",
       ylab="Global Active Power (kilowatts)", xlab="", col="Black")
  lines(ReqData[["Sub_metering_2"]]~Day, col="Red")
  lines(ReqData[["Sub_metering_3"]]~Day, col="Blue")
})

#Add Legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save Plot to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()