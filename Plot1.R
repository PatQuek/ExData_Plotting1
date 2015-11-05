
#This script will create a histogram and save a png file into the working directory

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


## Plot 1
hist(ReqData[["Global_active_power"]], main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")


## Save Plot to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()