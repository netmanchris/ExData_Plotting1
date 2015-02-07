# Load data, assumes the dataset has been downloaded and unzipped in the same directory as the R script

FullData <- tbl_df(read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"'))

#converts Date field is read as a date
FullData$Date <- as.Date(FullData$Date, format = "%d/%m/%Y")

#Subset the data
data <- filter(FullData, Date == "2007-02-01" | Date == "2007-02-02")
#removes FullData Data Table from memory
rm(FullData)

## Convert dates

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#draws plot for Plot 3
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
## Plot 3
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

## Save to file Plot3.png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
