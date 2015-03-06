## Download the repository: Dataset --> Electric power consumption
if (!file.exists("./data/household_power_consumption.txt")){
        ## Source file - URL
        URLFile <- "http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
        
        ## Destination file
        destFilezip = "./data/UDC.zip"
        
        ## Download file
        download.file (URLFile, destFilezip)
        
        ## Unzip file
        unzip (destFilezip, overwrite = T, exdir = "./data")
}


## Loading data from the dates 2007-02-01 and 2007-02-02
##powerConsumption <- file ("./data/household_power_consumption.txt")

## Loading the period of time to a data.table

EPC <- read.csv ("./data/household_power_consumption.txt",
                 header = T,
                 sep = ";",
                 na.strings = "?")


## convert the Date and Time variables to Date/Time classes 
strptime (EPC$Time, format = "%H:%M:%S")
EPC$Date <- as.Date(EPC$Date, format = "%d/%m/%Y")

## Extracting the period of time --> 2 days
EPC <- subset (EPC, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Column that contains a calendar dates and times, join EPC$Date + EPC$Time
EPC$datetime <- as.POSIXct (paste (EPC$Date, EPC$Time))

## Plot4
par (mfrow = c (2, 2),
     mar = c (4, 4, 2, 2),
     oma = c (0, 0, 1, 0))
with (EPC,{
        ## Upper-Left
        plot (Global_active_power ~ datetime,
              type = "l",
              ylab = "Global Active Power",
              xlab = "")
        ## Upper Right
        plot (Voltage ~ datetime, 
              type = "l",
              ylab = "Voltage",
              xlab = "datetime")
        ## Lower Left
        plot (Sub_metering_1 ~ datetime,
              type = "l",
              ylab = "Energy sub metering",
              xlab = "")
        lines (Sub_metering_2 ~ datetime, col = "Red")
        lines (Sub_metering_3 ~ datetime, col = "blue")
        legend ("topright", 
                legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                col = c ("black", "red", "blue"),
                lty = 1,
                lwd = 2               
        )
        ## Lower Right
        plot (Global_reactive_power ~ datetime,
              type = "l",
              ylab = "Global_reactive_power",
              xlab = "datetime")
})
dev.copy (png, file = "./data/plot4.png")
dev.off()