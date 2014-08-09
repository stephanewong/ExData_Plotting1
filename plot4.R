## EDA Project 1 - plot4
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

# plot4 = 4 plots: "Global active power over time", "Voltage" over time
# "Energy sub metering" over time, "Global_reactive_power" over time

# common x values for all plots 
x <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
            select = Time)[,1]

# y values "Global_active_power" for 1st plot 
y1 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
            select = Global_active_power)[,1]

# y values, "Voltage" for 2nd plot 
y2 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
             select = Voltage)[,1]

# y values "Sub_metering_1..3" for 3rd plot 
y31 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
             select = Sub_metering_1)[,1]
y32 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
             select = Sub_metering_2)[,1]
y33 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
             select = Sub_metering_3)[,1]

# y values "Global_reactive_power" for 4th plot 
y4 <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
             select = Global_reactive_power)[,1]

# plot in a 2 by 2 matrix
par(mfrow = c(2,2))

# adjusting margins instead of standard
# standard = par(mar = c(5.1, 4.1, 4.1, 2.1)
par(mar = c(4, 3.5, 3, 1.5))

# generate 1st plot
plot(x, y1, type = "l", ann = FALSE, cex.axis = 0.7)
mtext(side = 2, "Global active power", line = 2.5, cex = 0.7)

# generate 2nd plot
plot(x, y2, type = "l", ann = FALSE, cex.axis = 0.7)
mtext(side = 1, "datetime", line = 2.5, cex = 0.7)
mtext(side = 2, "Voltage", line = 2.5, cex = 0.7)

# generate 3rd plot
plot(x, y31, type = "l", ann = FALSE, cex.axis = 0.7)
lines(x, y32, col = "red")
lines(x, y33, col = "blue")
mtext(side = 2, "Energy sub metering", line = 2.5, cex = 0.7)

legend("topright", lty = 1, col= c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.6)

# generate 4th plot
plot(x, y4, type = "s", ann = FALSE, cex.axis = 0.7, lwd = 0.5)
mtext(side = 1, "datetime", line = 2.5, cex = 0.7)
mtext(side = 2, "Global_reactive_power", line = 2.5, cex = 0.7)

# store in PNG file
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()

# Back to 1x1 normal matrix
par(mfrow = c(1,1))
# Back to my local French time
Sys.setlocale("LC_TIME","French_France")
