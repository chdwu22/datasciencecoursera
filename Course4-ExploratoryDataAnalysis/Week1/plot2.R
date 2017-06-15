data <- read.table("household_power_consumption.txt", header = TRUE, sep= ";")
filter <- data$Date=="1/2/2007"| data$Date=="2/2/2007"

dates <- as.Date(data$Date, format = "%d/%m/%Y")
start_date <- as.Date("1/2/2007", format = "%d/%m/%Y")

global_active_power <- data$Global_active_power[filter]
global_active_power <- as.numeric(levels(global_active_power))[global_active_power]

plot(global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xaxt = "n")
axis(1, at=seq(1, length(global_active_power), length.out = 3), 
     labels=c(weekdays(start_date), weekdays(start_date+1), weekdays(start_date+2)))

dev.copy(png, file = "plot2.png")
dev.off()
