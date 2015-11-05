
#This script will plot 4 charts in one
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

#Setting up 4 in 1 charts
par(mfrow=c(2,2))

#Setting margins
par (mar=c(4,4,2,1), oma=c(0,0,2,0))


#Plot 1  
plot(ReqData[["Global_active_power"]]~Day, type="l", 
       ylab="Global Active Power", xlab="")
  
#Plot 2
plot(ReqData[["Voltage"]]~Day, type="l", 
       ylab="Voltage", xlab="datetime")
  
#Plot 3
plot(ReqData[["Sub_metering_1"]]~Day, type="l",
         ylab="Global Active Power (kilowatts)", xlab="", col="Black")
    lines(ReqData[["Sub_metering_2"]]~Day, col="Red")
    lines(ReqData[["Sub_metering_3"]]~Day, col="Blue")
    
#Add Legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
  
#Plot 4
plot(ReqData[["Global_reactive_power"]]~Day, type="l",
         ylab="Global_reactive_power", xlab="datetime")

    


## Save Plot to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

