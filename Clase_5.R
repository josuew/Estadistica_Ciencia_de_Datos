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
table(anios >= 1980)

sismos2 <- sismos[anios >= 1980,]
sismos2