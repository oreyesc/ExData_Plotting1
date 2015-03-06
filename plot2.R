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

## Plot2
plot (EPC$Global_active_power ~ EPC$datetime, 
      type = "l", 
      ylab = "Global Active Power (kilowatts)", 
      xlab = "")
dev.copy (png, file = "./data/plot2.png")
dev.off()
