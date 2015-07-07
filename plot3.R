# Author: Angela Di Serio
# Course: Exploratory Data Analysis
# Date:   July 2015
# Course  Project 1
#         Plot 3
# Script to visualize household energy usage over a 2-day period in February 2007
#-------------------------------------------------------------------------------------

# Step 1.
# This script requires the dplyr  and lubridate packages
# dplyr and lubridate packages will be installed if necessary

list.of.packages <- c("dplyr","lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

require(dplyr)
require(lubridate)
 
# Step 2.
# read data from the Electric power consumption dataset from 
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

# Since we will only be using data from the dates 2007-02-01 and 2007-02-02, 
# only the data from these two days will be read
# Note: missing values are coded as ?

message("Reading Electric Power Consumption Dataset")
flush.console()
if (!file.exists("./household_power_consumption.txt")) {
	stop("File household_power_consumption.txt not found")
}	
 
powCons<- read.table("household_power_consumption.txt",header=T,sep=";",na.strings="?") %>% 
filter(dmy(Date)==dmy("01/02/2007") | dmy(Date)==dmy("02/02/2007"))
		  
powCons$Date<-dmy(powCons$Date)

# Step 3. 
# Plot of Sub metering
par(mfrow=c(1,1))

plot(strptime(paste(powCons$Date,powCons$Time),format="%Y-%m-%d %H:%M:%S"),powCons$Sub_metering_1,
    type="l",xlab="",ylab="Energy sub metering",main="", bg="transparent")
lines(strptime(paste(powCons$Date,powCons$Time),format="%Y-%m-%d %H:%M:%S"),powCons$Sub_metering_2,
    col="red",main="", bg="transparent")
lines(strptime(paste(powCons$Date,powCons$Time),format="%Y-%m-%d %H:%M:%S"),powCons$Sub_metering_3,
    col="blue",main="", bg="transparent")
	
legend("topright", lty=1, col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.75)

# Step 4. Save the plot to a PNG file (480 x 480 px)    
dev.copy(png, file = "plot3.png",width=480,height=480)
dev.off()
   