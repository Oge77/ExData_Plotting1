## loading, unzipping and reading the file

Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url, destfile = "./household_power_consumption.zip", method = "curl")
unzip("./household_power_consumption.zip", exdir= "./household_power_consumption.txt")
epm <- read.csv("./household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?")
str(epm)
## converting the Date and Time variables to Date/Time classes
epm$Date <- as.Date(epm$Date, format = "%d/%m/%Y")
class(epm$Date)
library(dplyr)
subsetepm <- filter(epm, Date == "2007-02-01" | Date == "2007-02-02")
subsetepm$DateTime <- paste(subsetepm$Date,subsetepm$Time)
subsetepm$DateTime <- strptime(subsetepm$DateTime, format = "%Y-%m-%d %H:%M:%S")
class(subsetepm$DateTime)
head(subsetepm)

## plotting
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 3, 2))
hist(subsetepm$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()
