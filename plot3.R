
library(lubridate)
fulltbl<- read.table("hpc.txt", header=TRUE, stringsAsFactors=FALSE, sep=";")

subtbl<-fulltbl[month(dmy(fulltbl$Date))==2, ]
subtbl<-subtbl[day(dmy(subtbl$Date))<3, ]
subtbl<-subtbl[year(dmy(subtbl$Date))==2007, ]

png(file = "plot3.png", width=420, height=420)
plot(as.numeric(subtbl$Sub_metering_1)~dmy_hms(paste(subtbl$Date,subtbl$Time)), type="n", xlab="", ylab="Energy Sub Metering")
lines(as.numeric(subtbl$Sub_metering_1)~dmy_hms(paste(subtbl$Date,subtbl$Time)))
lines(as.numeric(subtbl$Sub_metering_2)~dmy_hms(paste(subtbl$Date,subtbl$Time)), col=2)
lines(as.numeric(subtbl$Sub_metering_3)~dmy_hms(paste(subtbl$Date,subtbl$Time)), col=4)
legend("topright", legend=c("Sub Metering 1", "Sub Metering 2","Sub Metering 3"), lty=c(1,1), lwd=c(2.5,2.5),col=c("black","blue","red"))
dev.off()
