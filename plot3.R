## plot3 function: makes a plot of Energy sub metering for 01/02/2007 and 02/02/2007. 
## arguments: datafilepath, optional. Path to the data file to read. Default to current directory with default file name.
## output: plot3.png, in current directory.

plot3 <- function(datafilepath="household_power_consumption.txt"){
    
    ## read the data
    data<-read.table(datafilepath, sep=";", header=TRUE, stringsAsFactors=FALSE)
    data$Date<-as.Date(data$Date, format="%d/%m/%Y")
    
    ## select data from the 2 days of interest
    data<-subset(data, data$Date==as.Date("2007-02-01") | data$Date==as.Date("2007-02-02"))
    
    ## merge date and time into single time variable
    time<-strptime(paste(data$Date,data$Time), format = "%Y-%m-%d %H:%M:%S")
    
    
    ## convert to numeric 
    data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
    data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
    data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
    

    ## plot into png file
    png(filename="plot3.png", width = 480, height = 480, units = "px")
    plot(time, data$Sub_metering_1, ylab="Energy sub metering", xlab="", type='n')
    lines(time, data$Sub_metering_1)
    lines(time, data$Sub_metering_2, col="red")
    lines(time, data$Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lwd=1)
    dev.off()
}