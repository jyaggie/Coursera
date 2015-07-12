
library(lubridate)
fulltbl<- read.table("hpc.txt", header=TRUE, stringsAsFactors=FALSE, sep=";")

subtbl<-fulltbl[month(dmy(fulltbl$Date))==2, ]
subtbl<-subtbl[day(dmy(subtbl$Date))<3, ]
subtbl<-subtbl[year(dmy(subtbl$Date))==2007, ]

png(file = "plot1.png", width=420, height=420)
hist(as.numeric(subtbl$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col=2)
dev.off()
