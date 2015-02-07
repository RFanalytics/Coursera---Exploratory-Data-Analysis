# Coursera - Exploratory Data Analysis - Project 1 - graph 2 #
# This script assumes you have the file "household_power_consumption.txt" in your working directory

library(plyr)
library(dplyr)


    house <- read.table("household_power_consumption.txt", 
                        sep = ";", 
                        header = TRUE, 
                        as.is = TRUE, 
                        na.strings=c("NA", "?"),
                        )                                       # read in the data

    
    day <- paste(house$Date,house$Time, sep = "")               # paste Date and Time together into one character vector

    day <- as.POSIXct(day, format = "%d/%m/%Y %H:%M:%S")        # using as.POSIXct in place of strptime becasue dplyr does not take POSIXlt

    house$day <- day                                            # add the POSIXct "day" column to "house" dataframe


    house$Date <- as.Date(house$Date, format = "%d/%m/%Y")      # coerce Date to date format so I can use dplyr to filter


    day.one <- filter(house, Date == "2007-02-01")              # easier for me to read in one day at a time
    day.two <- filter(house, Date == "2007-02-02")

    rm(house)                                                   # get rid of the big data frame - save memory

    small.house <- rbind(day.one, day.two)                      # combine the two days into one dataframe for plotting
    

    plot2 <- plot(small.house$day, small.house$Global_active_power,
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)", 
                  cex.lab = .75,
                  cex.axis = .75,
                  type = "n",
                  )                                             # type = "n" means don't plot dots, cex = .75 seems to match example

    lines(small.house$day, small.house$Global_active_power)     # draws the line from data point to data point
   
    dev.copy(png, file = "plot2.png")

    dev.off()


