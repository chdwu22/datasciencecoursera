data <- read.table("household_power_consumption.txt", header = TRUE, sep= ";")
filter <- data$Date=="1/2/2007"| data$Date=="2/2/2007"

dates <- as.Date(data$Date, format = "%d/%m/%Y")
start_date <- as.Date("1/2/2007", format = "%d/%m/%Y")

Sub_metering_1 <- data$Sub_metering_1[filter]
Sub_metering_1 <- as.numeric(levels(Sub_metering_1))[Sub_metering_1]
Sub_metering_2 <- data$Sub_metering_2[filter]
Sub_metering_2 <- as.numeric(levels(Sub_metering_2))[Sub_metering_2]
Sub_metering_3 <- data$Sub_metering_3[filter]

plot(Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", xaxt = "n")
axis(1, at=seq(1, length(global_active_power), length.out = 3), 
     labels=c(weekdays(start_date), weekdays(start_date+1), weekdays(start_date+2)))
lines(Sub_metering_1)
lines(Sub_metering_2, col = "red")
lines(Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = c(1,1,1), lwd = c(1,1,1), col = c("black","red","blue"), xjust = 0)


dev.copy(png, file = "plot33.png")
dev.off()

