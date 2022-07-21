library(dplyr)
library(lubridate)

filetxt<-"D:/Documents Ddrive/R/datasciencecoursera/ExploratoryAnalysis/household_power_consumption.txt"

filetxt2<-"C:/Users/LEONG.JPL-6BS6NG3.000/Documents/R/a1/drive-download-20220719T043353Z-001/household_power_consumption.txt"

# Get Memory used by one data object
object.size(filetxt)

data<-read.table(file=filetxt2,header = TRUE,sep=";",skipNul = T)
data2<-read.table(file=filetxt,header = TRUE,sep=";",skipNul = T)
data2<-read.table(file=filetxt2,header = TRUE,sep=";",skipNul = T)

head(data)

glimpse(data)

dim(data)

View(data)

# Only use dates from 2007-02-01 and 2007-02-02
head(data$Date)

data2[,1]<-as.Date(data$Date, "%d/%m/%Y")

glimpse(data2)

tail(data2)

data3<-data2[data2$Date >= "2007-02-01" & data2$Date<="2007-02-02",]

glimpse(data3)

# Fix data types

data3$Time<-hms::as_hms(data3$Time)

data3$Global_active_power<-as.numeric(data3$Global_active_power)

data3$Global_reactive_power<-as.numeric(data3$Global_reactive_power)

data3$Voltage<-as.numeric(data3$Voltage)

data3$Global_intensity<-as.numeric(data3$Global_intensity)

data3$Sub_metering_1<-as.numeric(data3$Sub_metering_1)

data3$Sub_metering_2<-as.numeric(data3$Sub_metering_2)

View(data3)

data3[,"day"]<-wday(data3$Date, label=T)

data3freq<-table(data3$Global_active_power)

View(data3freq)

# Plot 4
# Save as png size 480 x 480
png(file="plot4.png", width= 480, height = 480)

# Combine date and time
data3[,"datetime"]<-with(data3, ymd(Date) + hms(Time))

par(mfrow = c(2,2))

# Top left
plot(data3$datetime,data3$Global_active_power,type = "l",ylab= "Global Active Power (kilowatts)", xlab ="")

# Top right
plot(data3$datetime,data3$Voltage,type = "l",ylab= "Voltage", xlab ="datetime")

# Bottom left
plot(data3$datetime,data3$Sub_metering_1,type = "l",ylab= "Energy sub metering", xlab ="", col = "black")
lines(data3$datetime,data3$Sub_metering_2, col = "red")
lines(data3$datetime,data3$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lty=1, box.col = "white")
box(col="black")

# Bottom right
plot(data3$datetime,data3$Global_reactive_power,type = "l",ylab= "Voltage", xlab ="datetime")

dev.off()
