# This R script assumes that the file for data downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# is unzipped into the working directory. Now the data file 
# "household_power_consumption.txt" can be found in the working directory.

# Plot 3 is the time series of Global Active Power by the three submeters

file<-"household_power_consumption.txt" 					# file name as character string

sql_statement<-"SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"# Sql statement as character string 

library(sqldf) 									# Load package: sqldf

data<-read.csv2.sql(file,sql_statement,header=TRUE,				# Read only the specified data from dates:
				colClasses=c('character','character',		# 1/2/2007 and 2/2/2007. In addition,	
				'numeric','numeric','numeric','numeric',	# specify the column classes (columns date and time as
				'numeric','numeric','numeric'),na.strings='?')	# character and the remaining seven columns as numeric.
										# specify missing values as '?' in the dataset

data$date.time <- strptime(paste(data$Date, data$Time),				# Create a new column of class 'Date' called date.time  
                          "%d/%m/%Y %H:%M:%S")					# with the specified date-time format.

png("Plot3.png", height=480, width=480)						# Create a png file (Plot3.png) of height = 480 pixels
										# and width = 480 pixels.

plot(data$date.time,data$Sub_metering_1,pch=NA,xlab="",				# Plot the x and y axis and label them
     ylab="Energy sub metering")

lines(data$date.time, data$Sub_metering_1)					# Plot line for sub meter 1 against date.time
lines(data$date.time, data$Sub_metering_2,col='red')				# Plot line for sub meter 2 against date.time
lines(data$date.time, data$Sub_metering_3,col='blue')				# Plot line for sub meter 3 against date.time

legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),	# Add legend to the plot
       lty = c(1,1,1),col = c('black', 'red', 'blue'))

dev.off()									# Close the graphic device.
