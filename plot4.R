rawdata = read.table("household_power_consumption.txt", header = TRUE, sep = ";")

dat = rawdata

#Clean data
dat = dat[dat$Global_active_power !="?",]
dat = dat[dat$Global_reactive_power !="?",]
dat = dat[dat$Global_intensity !="?",]
dat = dat[dat$Sub_metering_1 !="?",]
dat = dat[dat$Sub_metering_2 !="?",]
dat = dat[dat$Sub_metering_3 !="?",]


#convert to date and subset
dat$Date = as.Date(dat$Date, format="%d/%m/%Y")
as.Date("2007-02-01")
dat = subset(dat, dat$Date >= as.Date("2007-02-01"))
dat = subset(dat, dat$Date <= as.Date("2007-02-02"))
dat$DateTime = as.POSIXct(paste(dat$Date, dat$Time), format="%Y-%m-%d %H:%M:%S")

#convert to numeric
dat$Global_active_power = as.numeric(dat$Global_active_power)
dat$Global_reactive_power = as.numeric(dat$Global_reactive_power)
dat$Global_intensity = as.numeric(dat$Global_intensity)
dat$Sub_metering_1 = as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 = as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 = as.numeric(dat$Sub_metering_3)

dat$Global_active_power_kw = dat$Global_active_power / 1000

#plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#1
plot(dat$DateTime, dat$Global_active_power_kw, type="n", xlab = "", ylab = "Global Active Power")
lines(dat$DateTime, dat$Global_active_power_kw)

#2
plot(dat$DateTime, dat$Voltage, type="n", xlab = "datetime", ylab = "Voltage")
lines(dat$DateTime, dat$Voltage)

#3
plot(dat$DateTime, dat$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(dat$DateTime, dat$Sub_metering_1)
lines(dat$DateTime, dat$Sub_metering_2, col = "red")
lines(dat$DateTime, dat$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(2.5,2.5), bty="n")


#4
plot(dat$DateTime, dat$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power")
lines(dat$DateTime, dat$Global_reactive_power)

dev.off()