## plot1 function: makes a histogram of Global Active Power for 01/02/2007 and 02/02/2007. 
## arguments: datafilepath, optional. Path to the data file to read. Default to current directory with default file name.
## output: plot1.png, in current directory.

plot1 <- function(datafilepath="household_power_consumption.txt"){
    
    ## read the data
    data<-read.table(datafilepath, sep=";", header=TRUE, stringsAsFactors=FALSE)
    data$Date<-as.Date(data$Date, format="%d/%m/%Y")
    
    ## select data from the 2 days of interest
    data<-subset(data, data$Date==as.Date("2007-02-01") | data$Date==as.Date("2007-02-02"))
    
    ## convert to numeric 
    data$Global_active_power<-as.numeric(data$Global_active_power)
    
    ## plot into png file
    png(filename="plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
    with(data, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))
    dev.off()
}