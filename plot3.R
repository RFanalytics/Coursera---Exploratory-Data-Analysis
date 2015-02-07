# Coursera - Exploratory Data Analysis - Project 1 - graph 3 #
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


    house$Date <- as.Date(house$Date, format = "%d/%m/%Y")      # coerce "Date" to date format so I can use dplyr to filter


    day.one <- filter(house, Date == "2007-02-01")              # easier for me to read in one day at a time
    day.two <- filter(house, Date == "2007-02-02")
      rm(house)                                                 # get rid of the big data frame - save memory

    small.house <- rbind(day.one, day.two)                      # combine the two days into one dataframe for plotting
      rm(day.one, day.two)                                      # get rid of day.one and day.two - save memory

    png(file = "plot3.png", 
        width = 480, 
        height = 480, 
        units = "px")                                           # set up write to file BEFORE plotting

    plot3 <- plot(small.house$day, 
                  small.house$Sub_metering_1, 
                  type="l", 
                  xlab = "",
                  ylab = "Energy sub metering",
                  cex.lab = .75,
                  cex.axis = .75,
                  )                                             # plot the first line - note "type = "l""

    lines(small.house$day, 
          small.house$Sub_metering_2, 
          col="red")                                            # plot the second line


    lines(small.house$day, 
          small.house$Sub_metering_3, 
          col="blue")                                           # plot the third line


    legend("topright", 
           legend = c("Sub_metering_1", 
                      "Sub_metering_2", 
                      "Sub_metering_3"), 
           col = c("black", "red", "blue"), 
           lwd = .75, 
           cex = .75)                                           # build up the legend

    #dev.copy(png, file = "plot3.png")                          # I leave this line in here if I want to plot to screen
                                                                # instead of to file.....while working on the code
    dev.off()