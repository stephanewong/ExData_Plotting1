## EDA Project 1 - plot2
## Author: St�phane Wong
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

# plot2 = "Global_active_power" kilowatts over time
x <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
            select = Time)[,1]
y <- subset(elecpower, (Date == "2007-02-01") | (Date == "2007-02-02"),
            select = Global_active_power)[,1]
plot(x, y, type = "l", ylab = "Global active power (kilowatts)", xlab =""
     , cex.lab = 0.8, cex.axis = 0.8)

# store in PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()

# Back to my local French time
Sys.setlocale("LC_TIME","French_France")
