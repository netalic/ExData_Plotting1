## read file

data <- "household_power_consumption.txt"


# data from: 2007-02-01 and 2007-02-02.

plotdata  <- read.table(data, sep = ";", na.strings="?", skip=grep("1/2/2007", readLines(data)),nrows=2879,

                        col.names = colnames(read.table(data, sep=";",nrow = 1, header = TRUE)))

# plot 1

hist(plotdata$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col = "red")


# copy active window to png file

dev.copy(png,file = "plot1.png",width=480, height=480, units="px")

dev.off()
