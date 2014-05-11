# This R script assumes that the file for data downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# is unzipped into the working directory. Now the data file 
# "household_power_consumption.txt" can be found in the working directory.

# Plot 2 is the line graph for the time series of Global Active Power

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

png("Plot2.png", height=480, width=480)						# Create a png file (Plot2.png) of height = 480 pixels
										# and width = 480 pixels.

plot(data$date.time,data$Global_active_power,pch=NA,xlab="",    		# Plot the x and y axis and label them
     ylab="Global Active Power (kilowatts)")

lines(data$date.time,data$Global_active_power)                  		# Draw the lines from Global active power against date.time

dev.off()									# Close the graphic device.
