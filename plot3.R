## EDA Project 1 - plot3
## Author: Stéphane Wong
## Date: 9th August 2014

# Managing country language for dayname display
Sys.setlocale("LC_TIME","English_United States")

# load file with interpretation of "?" as NA value
elecpower <- read.table("./data/household_power_consumption.txt",
                        sep = ";",header = TRUE, na.strings = "?")
# column names are:
# "Date" "Time" "Global_active_power" "Global_reactive_power" "Voltage"
# "Global_intensity" "Sub_metering_1" "Sub_metering_2" "Sub_metering_3"

# format date/time columns to Data / Time R format instead of factor
# date example = "16/12/2006", time example = "17:24:00"
elecpower <- transform(elecpower, Date = as.Date(Date, "%d/%m/%Y"),
                       Time = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))

# plot3 = "Energy sub metering" over time
# "Sub_metering_1" "Sub_metering_2" "Sub_metering_3"
x <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
            select = Time)[,1]
y1 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
            select = Sub_metering_1)[,1]
y2 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
             select = Sub_metering_2)[,1]
y3 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
             select = Sub_metering_3)[,1]

# open PNG device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# make the plots
plot(x, y1, type = "l", ylab = "Energy sub metering", xlab ="",
     cex.lab = 0.8, cex.axis = 0.8)
lines(x, y2, col = "red")
lines(x, y3, col = "blue")

legend("topright", lty = 1, col= c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , cex = 0.8, yjust = 0)

# close PNG device
dev.off()

# Back to my local French time
Sys.setlocale("LC_TIME","French_France")
