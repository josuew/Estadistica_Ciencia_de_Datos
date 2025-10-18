x <- 5
sismos <- read.csv("data/SSNMX_catalogo_19000101_20251004 (1).csv")
dim(sismos)

# Obtiene las columnas del dataframe
colnames(sismos)

# Forzamos de un caracter a un fecha
fechas <- as.Date(sismos$Fecha, tryFormats = "%d/%m/%Y")

# Obtiene los meses de cada renglon
months(fechas)

# install.packages("lubridate")
library("lubridate")

#obtiene los anios de cada renglon
anios <- year(fechas)

# Obtiene los dias de cada tenglon
day(fechas)

#Permite generar etiquetas del mes y los ordena de mes a mes
meses <- month(fechas, label = TRUE)

# Tabla de frecuencias sobre meses
# Obtienes el mes que mas sismos hubo
table(meses)

# Anio con numero de sismos detectados
table(anios)

# Descartar datos antes de 1980
anios >= 1980

# Obtenemos cuantos a considerar y cuantos no
# table(anios >= 1980)

sismos2 <- sismos[anios >= 1980,]
dim(sismos)
dim(sismos2)

# Generar columna con las condiciones booleanas
sismos$anio <- anios
colnames(sismos)

# Filtramos por la columna que
sismos[sismos$anio >= 1980,]

sismos$anio <- anios
sismos$mes <- meses
sismos$dia <- day(fechas)

sismos2 <- sismos[sismos$anio >= 1980,]

# obtienes los meses donde hubo mas sismos de 1980 a adelante
table(sismos2$mes)

# Si tiene comillas significa que el numero no es calculable
sismos2$Magnitud

head(sismos$Magnitud, 50)
tail(sismos$Magnitud, 50)


sismos2$Magnitud <- as.numeric(sismos2$Magnitud)
sismos2$Magnitud

#Magnitud promedio de los sismos registrados en mexico a partir de 1980
mean(sismos2$Magnitud, na.rm = TRUE)

summary(sismos2$Magnitud)

# is.na(sismos2$Magnitud)
sismoper <- sismos2[sismos2$Magnitud == 8.200 & !is.na(sismos2$Magnitud),]

table(sismoper$mes)


sismoper <- sismos2[sismos2$Magnitud >= 5 & !is.na(sismos2$Magnitud),]
table(sismoper$mes)

estaturas <- c(69, 71, 67, 66, 59, 73, 80, 70, 72, 69, 68, 72, 59, 76,
               67, 74, 67, 74, 64, 63, 71, 66, 67, 62, 62, 57, 71, 56,
               69, 65, 79, 70, 71, 78, 75, 65, 61, 57, 59, 66,
               63, 61, 64, 61, 60, 62, 65, 59, 70, 77)

sum(estaturas) * (1 / length(estaturas)) # Media
mean(estaturas)

# Mediana
median(estaturas)
(sort(estaturas)[length(estaturas) / 2] +
  sort(estaturas)[(length(estaturas) / 2) + 1]) / 2
sort(estaturas)[25]

# Moda
# Elemento que mas se repite en los datos
frecuncias_esta <- table(estaturas)
max(frecuncias_esta)
elemento <- which(frecuncias_esta == max(frecuncias_esta))
dim(elemento)
length(elemento)
names(frecuncias_esta)[elemento]

# Medidas de Dispercion
# Rango
diff(range(estaturas))
max(estaturas) - min(estaturas)

# Rango quartil
ceiling(0.25 * length(estaturas))
ceiling(0.75 * length(estaturas))
estatu_orde <- sort(estaturas)
estatu_orde[ceiling(0.75 * length(estaturas))] -
  estatu_orde[ceiling(0.25 * length(estaturas))] # Rango intercuantilico

# round(0.25 * length(estaturas),0)
# round(0.75 * length(estaturas),0)

# Filtrar la base a registros validos
sismos2 <- sismos2[anios >= 1980,]
dim(sismos2)
sismos3 <- sismos2[!is.na(sismos2$Magnitud),]
# is.numeric(sismos2$Magnitud)
dim(sismos3)

# Rango
max(sismos3$Magnitud) - min(sismos3$Magnitud)

# Rango Intercuantilico de las maginitudes
sismo_orde <- sort(sismos3$Magnitud)
sismo_orde[trunc(length(sismos3$Magnitud) * 0.75)] - # Trunca
  sismo_orde[round(length(sismos3$Magnitud) * 0.25)] # Redondea

# El 50% de los sismos se encuentra entre 3.8 y 3.4 escala richter de 0.4

# Desviacion absoluta media - DAM
sum(abs(sismos3$Magnitud - mean(sismos3$Magnitud))) / length(sismos3$Magnitud) # Escalar
mean(sismos3$Magnitud)

# Varianza de los Sismos
vari_magni <- sum((sismos3$Magnitud - mean(sismos3$Magnitud)) ^ 2) / (length(sismos3$Magnitud) - 1)
sqrt(vari_magni)

# Mediana
sismo_orde[ceiling(length(sismos3$Magnitud) / 2)]
median(sismos3$Magnitud)

# Moda
frecu_sismo <- table(sismos3$Magnitud)
which(frecu_sismo == max(frecu_sismo))
names(frecu_sismo)[which(frecu_sismo == max(frecu_sismo))]

# which(sismos3$Estado2 == " OAx")
sismos3$Estado2[which(sismos3$Estado2 == " OAx")]<-" OAX"
table(sismos3$Estado2)

# Aggregate
# Estadisticas multivariadas
aggregate(Magnitud ~ Estado2,FUN=mean,data=sismos3) # Obtiene el promedio de magnitud por estado
aggregate(sismos3$Magnitud ~ sismos3$Estado2,FUN=mean,data=sismos3) # Obtiene el promedio de magnitud por estado
aggregate(sismos3$Magnitud ~ sismos3$Estado2,FUN=length) # Obtiene la cantidad de sismos

# Varianza
sqrt(var(sismos3$Magnitud) * 100) / mean(sismos3$Magnitud)

coef_var <- function (x){
  (sqrt(var(x))) * 100 / mean(x)
}

coef_var2 <- function (x){
  sd(x) * 100 /mean(x)
}

coef_var(sismos3$Profundidad)
aggregate(sismos3$Magnitud ~ sismos3$Estado2,FUN=coef_var,data=sismos3)
aggregate(sismos3$Magnitud ~ sismos3$Estado2,FUN=coef_var2,data=sismos3)

aggregate(cbind(sismos3$Magnitud,sismos3$Profundidad) ~ sismos3$Estado, FUN=mean)
aggregate(cbind(sismos3$Magnitud,sismos3$Profundidad, sismos3$Latitud) ~ sismos3$Estado, FUN=mean)


############################## DENGUE 2024
# Edad promedio por estado de las personas con dengue
# Edad promedio por estado y por sexo de personas con dengue
