# ctrl + l
x<-5
sismos<-read.csv("data/SSNMX_catalogo_19000101_20251004 (1).csv")
dim(sismos)
colnames(sismos)
fechas<-as.Date(sismos$Fecha,tryFormats = "%d/%m/%Y")

months(fechas)
install.packages("lubridate")
library(lubridate)
anios<-year(fechas)

meses<-month(fechas,label=TRUE)
table(meses)
table(anios)

sismos2<-sismos[anios>=1980 ,]
dim(sismos2)
dim(sismos)

sismos$anio<-anios
sismos$mes<-meses
sismos$dias<-day(fechas)

sismos2<-sismos[sismos$anio>=1980,]

table(sismos2$mes)

head(sismos2$Magnitud,50)
tail(sismos2$Magnitud,50)

sismos2$Magnitud<-as.numeric(sismos2$Magnitud)
mean(sismos2$Magnitud,na.rm=TRUE)
summary(sismos2$Magnitud)

is.na(sismos2$Magnitud)


sismoper<-sismos2[sismos2$Magnitud>=5 & !is.na(sismos2$Magnitud),]
table(sismoper$mes)


