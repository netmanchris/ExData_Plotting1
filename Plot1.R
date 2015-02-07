#loads dplyr package
library(dplyr)

# Load data, assumes the dataset has been downloaded and unzipped in the same directory as the R script

FullData <- tbl_df(read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"'))

#converts Date field is read as a date
FullData$Date <- as.Date(FullData$Date, format = "%d/%m/%Y")

#Subset the data
data <- filter(FullData, Date == "2007-02-01" | Date == "2007-02-02")
#removes FullData Data Table from memory
rm(FullData)

#draws histogram for Plot 1
par(mfrow=c(1,1))
hist(data$Global_active_power, main="Global Active Power", breaks = 25,
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Save to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
