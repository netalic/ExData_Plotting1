# read data

data <- "household_power_consumption.txt"

# data from: 2007-02-01 and 2007-02-02.

plotdata  <- read.table(data, sep = ";", na.strings="?", skip=grep("1/2/2007", readLines(data)),nrows=2879, col.names = colnames(read.table(data, sep=";",nrow = 1, header = TRUE)))

# convert date and time columns to R time classes


plot.dates<-as.character(plotdata$Date)

plot.times<-as.character(plotdata$Time)

plot.x    <- paste(plot.dates, plot.times)

plot.z    <- strptime(plot.x, "%d/%m/%Y %H:%M:%S")


# add date/time column to data frame

plotdata  <- cbind(plotdata,DateTime=plot.z) 


# convert time to day of week

plotdata$dayOfweek <- weekdays(as.Date(plotdata$DateTime),abbreviate = TRUE)

# create 4 subplot figure

par(mfcol=c(2,2),mar = c(4,4,1,1), oma = c(0,0,1,0))

# subplot (1,1)

# plot global active power vs. dayOfWeek

plot(plotdata$DateTime,plotdata$Global_active_power,xaxt="n", xlab = "", ylab="Global Active Power (kilowatts)",type = "l")

#figure out the lowest and highest months

daterange=c(as.POSIXlt(min(plotdata$DateTime)),as.POSIXlt(max(plotdata$DateTime))) 

axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), format="%a") #label the x axis by Days of week

# subplot(2,1)

plot(plotdata$DateTime,plotdata$Sub_metering_1,xaxt="n", xlab = "", ylab="Energy sub metering",type="n") 

with(plotdata,lines(DateTime,Sub_metering_1,xaxt="n", xlab = "", ylab="",type = "l", col = "black"))

with(plotdata,lines(DateTime,Sub_metering_2,xaxt="n", xlab = "", ylab="",type = "l", col = "red"))

with(plotdata,lines(DateTime,Sub_metering_3,xaxt="n", xlab = "", ylab="",type = "l", col = "blue"))

legend("topright", lwd = 1, col = c("black","red","blue"), legend = colnames(plotdata)[7:9])


#figure out the lowest and highest months

daterange=c(as.POSIXlt(min(plotdata$DateTime)),as.POSIXlt(max(plotdata$DateTime))) 

axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), format="%a") 

# subplot(1,2)

# plot voltage vs. dayOfWeek
plot(plotdata$DateTime,plotdata$Voltage,xaxt="n", xlab = "datetime",
ylab="Voltage",type = "l") 

#figure out the lowest and highest months

daterange=c(as.POSIXlt(min(plotdata$DateTime)),as.POSIXlt(max(plotdata$DateTime))) 

axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), format="%a") #label the x axis by Days of week


# subplot(2,2)
# plot Globar reactive power vs. dayOfWeek


plot(plotdata$DateTime,plotdata$Global_reactive_power,xaxt="n", xlab = "datetime",ylab = "Global_reactive_power",type = "l") 


#figure out the lowest and highest months

daterange=c(as.POSIXlt(min(plotdata$DateTime)),as.POSIXlt(max(plotdata$DateTime))) 

axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), format="%a")


# copy active window to png file

dev.copy(png,file = "plot4.png",width=480, height=480, units="px")

dev.off()

