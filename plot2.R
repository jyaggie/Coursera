
library(lubridate)
fulltbl<- read.table("hpc.txt", header=TRUE, stringsAsFactors=FALSE, sep=";")

subtbl<-fulltbl[month(dmy(fulltbl$Date))==2, ]
subtbl<-subtbl[day(dmy(subtbl$Date))<3, ]
subtbl<-subtbl[year(dmy(subtbl$Date))==2007, ]

png(file = "plot2.png", width=420, height=420)
plot(as.numeric(subtbl$Global_active_power)~dmy_hms(paste(subtbl$Date,subtbl$Time)), type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(as.numeric(subtbl$Global_active_power)~dmy_hms(paste(subtbl$Date,subtbl$Time)))
dev.off()
