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

# plot global active power vs. dayOfWeek

plot(plotdata$DateTime,plotdata$Global_active_power,xaxt="n", xlab = "", ylab="Global Active Power (kilowatts)",type = "l") 



#figure out the lowest and highest months

daterange=c(as.POSIXlt(min(plotdata$DateTime)),as.POSIXlt(max(plotdata$DateTime))) 

axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), 

             format="%a") #label the x axis by Days of week


# copy active window to png file

dev.copy(png,file = "plot2.png",width=480, height=480, units="px")

dev.off()
