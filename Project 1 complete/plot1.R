# This R script assumes that the file for data downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# is unzipped into the working directory. Now the data file 
# "household_power_consumption.txt" can be found in the working directory.

# Plot 1 is the histogram for the frequency distribution of Global Active Power
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

png("Plot1.png", height=480, width=480)						# Create a png file (Plot1.png) of height = 480 pixels
										# and width = 480 pixels.

hist(data$Global_active_power, col='red',					# Now create the histogram for Global active power
     xlab = 'Global Active Power (kilowatts)',					# and name the x and y axis appropriately.
     main = 'Global Active Power')
										
dev.off()									# Exit the graphic device.


