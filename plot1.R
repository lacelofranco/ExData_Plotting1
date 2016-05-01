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

par(mfrow=c(1,1))

#plot 1
png("plot1.png", width = 480, height = 480)
dat$Global_active_power_kw = dat$Global_active_power / 1000
hist(dat$Global_active_power_kw, col = "Red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
