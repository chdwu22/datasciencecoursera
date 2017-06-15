data <- read.table("household_power_consumption.txt", header = TRUE, sep= ";")
date_filter <- data[,1]=="1/2/2007"| data[,1]=="2/2/2007"
global_active_power <- data[,3][date_filter]
global_active_power <- as.numeric(levels(global_active_power))[global_active_power]
hist(global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()
