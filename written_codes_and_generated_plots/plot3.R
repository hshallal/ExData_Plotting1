## Data preparation by subsetting and converting date and time columns into date and time classes

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings=c("?"), comment.char = "")
data1 <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
data1[,1] <- as.character(data1[,1])
data1$Date[data1$Date == "1/2/2007"] <- "2007-02-01"
data1$Date[data1$Date == "2/2/2007"] <- "2007-02-02"
data1[,1] <- as.Date(data1[,1])
data2 <- paste(data1[,1], data1[,2])
POSIXt <- strptime(data2, format = "%Y-%m-%d %H:%M:%S")
data3 <- cbind(POSIXt, data1)

## Plotting and saving as a .png file

png('plot3.png')
plot(Sub_metering_1 ~ POSIXt, data3, type = 'l', xlab = "", ylab = "Energy sub metering")
lines(Sub_metering_3 ~ POSIXt,  data3, col = "blue", type = 'l')
lines(Sub_metering_2 ~ POSIXt,  data3, col = "red",  type = 'l')
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black", "red","blue"), lty = 1)
dev.off()


