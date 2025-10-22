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

#--- Clase 3 ---
# Poblacion: Es el conjunto "completo" de una poblacion
# Muestra: Es un subconjunto de la poblacion al que se le pueden realizar mediciones

# Parametro: Cantidad numerica calculada sobre la poblacion (por ejemplo la altura media de los mexicanos), se representa
# con la letra µ(mu) o S (sigma)
# Estadistico: Cantidad numerica calculada sobre una muestra (la altura media de un salon de clases), se representa con
# la letra, se le puede llamar estimador tambien, como la desviacion estandar o el promedio

# Variable: Es la caracteristica que se quiere estudiar de la poblacion (estatura de los mexicanos)
# Dato u observacion: Es la realizacion (medicion) de la variable de interes
# Experimento: Actividad o proceso realizado cuyos resultados producen un conjunto de datos

# Tipos de Variables
# Cualitativas
#   Nominal - No se guarda relacion entre ellas, no importa el orden y se guardan en etiquetas (un ejemplo es el sexo, masculina o femenino)
#   Ordinal - Importa el Orden y se guardan en etiquetas (por ejemplo el nivel socioeconomico: nivel bajo, medio o alto)
# Cuantitativas
#   Intervalo - Temperatura o calificacion de un examen
#   Razon - Estatura, peso o distancia (cero absoluto)
#   Absoluto - Hijos por familia

# Probabilidad
# Es una medida de incertidumbre asociada a un experimento aleatorio. Es un valor entre 0 y 1 que resulta
# del cociente entre el numero de casos favorables al evento (m) y el numero de casos totales del evento (n)
# P(A) = m / n

# Experimento Aleatorio
# Experimento cuyo resultado es incierto apeasar de realizar dicho experimento en las mismas condiciones (lanzar moneda)

# Espacio muestral
# Conjunto de "todos" los resultados posibles de un experimento aleatorio (Ω)

# Evento
# Objeto de estudio de la teoria de probabilidades

# Medidas de tendencia central
# Moda: EL dato que mas se repite de los elementos, pueden existir elementos duplicados
# Mediana: Son datos ORDENADOS en medio, si hay pares se suman los 2 elmentos medios y se saca el promedio de esos 2 datos
#           Tambien es el punto medio de la distribucion de frecuencias. NO PUEDEN EXISTIR ELEMENTOS DUPLICADOS
#           --- Calculo Mediana ---
#           - Impar: n = 2k + 1
#                   Se obtiene tomando el elemento de en medio, es decir si tienes 7 datos el elemento 4 es la mediana
#                   - Ejemplo
#                     1,2,3,4,5,6,7
#                     n = 2(4) + 1 = 9
#           - Par: n = 1/2 (Xk-1 + Xk+1)
#                   Se obtiene dividiendo entre 2 el total de los elementos y se toma el de abajo y el de arriba, se suman y se multiplican por 1/2
#                   - Ejemplo
#                     1,2,3,4,5,6,7,8
#                     1. Se Ordenan
#                     2. Posiciones Medias, 8/2 = 4 y 8/2 + 1 = 5
#                     n = 1/2 (4 + 5) = 4.5
# Media - Es el promedio


estaturas <- c(69, 71, 67, 66, 59, 73, 80, 70, 72, 69, 68, 72, 59, 76,
               67, 74, 67, 74, 64, 63, 71, 66, 67, 62, 62, 57, 71, 56,
               69, 65, 79, 70, 71, 78, 75, 65, 61, 57, 59, 66,
               63, 61, 64, 61, 60, 62, 65, 59, 70, 77)

sum(estaturas) * (1 / length(estaturas)) # Media
mean(estaturas) # Media

# Mediana
length(estaturas) %% 2 == 0 # es par?
# 1. Ordena
estaturas_ordenadas <- sort(estaturas)
(estaturas_ordenadas[length(estaturas) / 2] +
  estaturas_ordenadas[(length(estaturas) / 2) + 1]) * 0.5 # (Xk - 1 + Xk + 1) * 1/2
median(estaturas) # Ya ordena los valores y le saca la mediana

# Moda
# Elemento que mas se repite en los datos
frecuencias_esta <- table(estaturas) # Genera un arreglo con etiquetas con las estaturas y su contador de elementos
frecuencias_esta
max(frecuencias_esta) # Obtiene el valor maximo de la tabla de frecuencias, no la posicion del elemento maximo de frecuencias, es decir
#                       el elemento maximo es 4 en la tabla de frecuencias

# utilizando which obtenemos cual es el elemento maximo de la tabla de frecuencias y no el valor de las frecuencias
which.max(frecuencias_esta)
elemento <- which(frecuencias_esta == max(frecuencias_esta)) # Moda, retorna un Arreglo con las posiciones de la condicion logica
elemento

dim(elemento) # Aqui podemos ver que retorna NULL, el cual nos dice que es un arreglo
length(elemento) # contiene 3 elementos
names(frecuencias_esta) # Retorna el nombre de las etiquetas de la tabla de frecuencias
names(frecuencias_esta)[elemento] # Retorna el nombre de los valores mayormente repetidos

# Medidas de Dispercion
# Una vez que se han estimado medidas de tendencia central lo siguiente son las medidas de dispercion
# Digamos que la dispercion significa "separarse entre si"
# las medidas de dispercion indican la variacion de los datos
# estas se aplican a variables continuas (razon e intervalo)

# Rango
# Es la diferencia entre la observacion mayor con la menor

# Rango Interquartil
# Su principal objetivo es eliminar los datos extremos, es decir el menor y el mayor
# Los datos se dividen en 4 (quartil)
# 0.25 - Primer Quartil
# 0.50 - Segundo Quartil
# 0.75 - Tercer Quartil
# 1 - Cuarto Quartil
# Rango Interquartil = X al 0.75 - X al 0.25 (se toma el dato en la posicion 0.75 y el dato en la posicion 0.25 y se restan)
# 1. Se ordenan los datos
# 2. De la cantidad de datos n es igual a arreglo[N * P] donde p es el quartil que queremos y N son la cantidad de elementos, esto
#     para obtener las posiciones de los quartiles, el valor de [N*P] SE REDONDEA

# Desviacion Media Absoluta
# Si los datos estan cercanos a "cero" (porque se resta el elemento - media) nos dice que los "errores" respecto al promedio son minimos
# 1. Tomamos cada elemento y lo restamos con la media
# 2. Sacamos su valor absoluto
# 3. Los dividimos entre los elementos [n]

# Varianza
#
# 1. Tomamos cada elemento y lo restamos con la media
# 2. El Resultado se eleva al cuadrado
# 3. se toma 1 / n - 1
# Desventaja es que todo de eleva al cuadrado, es decir anios al cuadrado


# Desviacion estandar
# Se toma lo mismo que la varianza pero con una raiz cuadrada al final
# 1. Tomamos cada elemento y lo restamos con la media
# 2. El Resultado se eleva al cuadrado
# 3. se toma 1 / n - 1
# 4. raiz cuadrada del resultado

# Coeficiente de Vaciacion
# Se obtiene el porcentaje de dispercion
# 1. Se obtiene la desviacion estandar
# 2. Se obtiene el promedio
# 3. Se multiplica la desviacion estandar por 100 entre el promedio

# Rango
max(estaturas) - min(estaturas)
range(estaturas) # Retorna valores maximo y min
diff(range(estaturas))

 # Rango intercuantilico
ceiling(0.25 * length(estaturas))
ceiling(0.75 * length(estaturas))
estatu_orde <- sort(estaturas)
estatu_orde[ceiling(0.75 * length(estaturas))] -
  estatu_orde[ceiling(0.25 * length(estaturas))]

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
diff(range(sismos3$Magnitud))

# Rango Intercuantilico de las magnitudes
# h=1+(n−1)×p
sismo_orde <- sort(sismos3$Magnitud)
pos_quartil_3 <- 1 + (length(sismos3$Magnitud) - 1) * 0.75
pos_quartil_3 # 252742.8
pos_quartil_1 <- 1 + (length(sismos3$Magnitud) - 1) * 0.25
pos_quartil_1

#Interpolacion
# la posicion quartil 3 indica que esta entre las posiciones 252742 y 252743
quartil_3 <- sismo_orde[floor(pos_quartil_3)] + 0.75 * (sismo_orde[floor(pos_quartil_3)] - sismo_orde[ceiling(pos_quartil_3)])
quartil_3

quartil_1 <- sismo_orde[floor(pos_quartil_1)] + 0.25 * (sismo_orde[floor(pos_quartil_1)] - sismo_orde[ceiling(pos_quartil_1)])
quartil_1

iqr <- quartil_3 - quartil_1
iqr

# h=1+(n−1)×p
sismo_orde[trunc(length(sismos3$Magnitud) * 0.75)] - # Trunca
  sismo_orde[round(length(sismos3$Magnitud) * 0.25)] # Redondea
IQR(sismos3$Magnitud)


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
