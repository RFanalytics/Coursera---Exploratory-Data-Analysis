# Coursera - Exploratory Data Analysis - Project 1 - graph 1#
# This script assumes you have the file "household_power_consumption.txt" in your working directory

library(plyr)
library(dplyr)


    house <- read.table("household_power_consumption.txt", 
                        sep = ";", 
                        header = TRUE, 
                        as.is = TRUE, 
                        na.strings=c("NA", "?"),
                        )                                       # read in the data

    house$Date <- as.Date(house$Date, format = "%d/%m/%Y")      # coerce Date to date format

    day.one <- filter(house, Date == "2007-02-01")              # easier for me to read in one day at a time
    day.two <- filter(house, Date == "2007-02-02")

    rm(house)                                                   # get rid of the big data frame - save memory

    small.house <- rbind(day.one, day.two)                      # combine the two days into one dataframe for plotting

    
    plot1 <- hist(small.house$Global_active_power, col = "red",
                  xlab ="Global Active Power (kilowatts)",
                  ylab = "Frequency", cex.lab = .75,
                  main = "Global Active Power", cex.main = 1,
                  cex.axis = .75
                  )


    plot1   # plot the hist to the screen to see it
  
    dev.copy(png, file = "plot1.png")

    dev.off()

