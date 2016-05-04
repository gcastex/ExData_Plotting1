## plot3 function: makes a grid of 4 plots for energy use on 01/02/2007 and 02/02/2007. 
## arguments: datafilepath, optional. Path to the data file to read. Default to current directory with default file name.
## output: plot4.png, in current directory.

plot4 <- function(datafilepath="household_power_consumption.txt"){
    
    ## read the data
    data<-read.table(datafilepath, sep=";", header=TRUE, stringsAsFactors=FALSE)
    data$Date<-as.Date(data$Date, format="%d/%m/%Y")
    
    ## select data from the 2 days of interest
    data<-subset(data, data$Date==as.Date("2007-02-01") | data$Date==as.Date("2007-02-02"))
    
    ## merge date and time into single time variable
    datetime<-strptime(paste(data$Date,data$Time), format = "%Y-%m-%d %H:%M:%S")
    
    
    ## convert to numeric 
    data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
    data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
    data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
    data$Global_active_power<-as.numeric(data$Global_active_power)
    data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
    data$Voltage<-as.numeric(data$Voltage)
    
    ##----- plot -----
    ## open png file
    png(filename="plot4.png", width = 480, height = 480, units = "px", bg = "transparent")

    ## grid of 4 plots
    par(mfrow=c(2,2), cex=0.8)
    
    ## 1st plot
    plot(datetime, data$Global_active_power, ylab="Global Active Power", xlab="", type='n')
    lines(time, data$Global_active_power)
    
    ## 2nd plot
    plot(datetime, data$Voltage, ylab="Voltage", type='n')
    lines(datetime, data$Voltage)
    
    ## 3rd plot
    plot(datetime, data$Sub_metering_1, ylab="Energy sub metering", xlab="", type='n')
    lines(datetime, data$Sub_metering_1)
    lines(datetime, data$Sub_metering_2, col="red")
    lines(datetime, data$Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lwd=1, bty="n")
    
    ## 4th plot
    plot(datetime, data$Global_reactive_power, ylab="Global_reactive_power", type='n')
    lines(datetime, data$Global_reactive_power)
    
    ## closes the png file
    dev.off()
}