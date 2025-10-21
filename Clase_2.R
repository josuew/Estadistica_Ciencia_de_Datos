sismos <- read.csv("data/SSNMX_catalogo_19000101_20251004 (1).csv") # Genera un DataFrame
is.data.frame(sismos)

dim(sismos) # Obtiene los elementos del archivo csv con las columnas

# Obtiene las columnas del dataframe
colnames(sismos)

# Forzamos de un caracter a un fecha
inherits(sismos$Fecha, 'Date')
fechas <- as.Date(sismos$Fecha, tryFormats = "%d/%m/%Y")
inherits(fechas, 'Date')

# Obtiene los meses de cada renglon de manera escrita
months(fechas)

# install.packages("lubridate")
library("lubridate")

#obtiene los anios de cada renglon
anios <- year(fechas)
anios

# Obtiene los dias de cada tenglon
day(fechas)

#Permite generar etiquetas del mes y los ordena de mes a mes
month(fechas)
meses <- month(fechas, label = TRUE) # Label permite mostrar los caracteres del mes
meses

# Tabla de frecuencias sobre meses
# Obtienes un conteo de frecuencias
table(meses)

# Anio con numero de sismos detectados
table(anios)

# Descartar datos antes de 1980
anios >= 1980

# Obtenemos cuantos a son verdaderos/falsos de anios >= 1980
# Digamos que es mas un indicador de filas
table(anios >= 1980)

# Muestra todas las filas mayores a 1980 en anios y muestra todas las columnas
sismos2 <- sismos[anios >= 1980,]
dim(sismos)
dim(sismos2)

# Generar columna con las condiciones booleanas
sismos$anio <- anios
colnames(sismos)
sismos

# Filtramos por la columna que
sismos[sismos$anio >= 1980,]

sismos$anio <- anios
sismos$mes <- meses
sismos$dia <- day(fechas)

sismos2 <- sismos[sismos$anio >= 1980,]

# obtienes los meses donde hubo mas sismos de 1980 en adelante
table(sismos2$mes)

# Si tiene comillas significa que el numero no es calculable
sismos2$Magnitud

head(sismos$Magnitud, 50)
tail(sismos$Magnitud, 50)


sismos2$Magnitud <- as.numeric(sismos2$Magnitud)
sismos2$Magnitud

#Magnitud promedio de los sismos registrados en mexico a partir de 1980
mean(sismos2$Magnitud, na.rm = TRUE)

# Obtiene un resumen de la columna magnitud de los sismos apartir de 1980
summary(sismos2$Magnitud)

is.na(sismos2$Magnitud)
sismoper <- sismos2[sismos2$Magnitud == 8.200 & !is.na(sismos2$Magnitud),]

table(sismoper$mes)