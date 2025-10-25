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
dim(sismos2)

# Filtrado
library(lubridate)
fechas <- as.Date(sismos$Fecha, tryFormats = "%d/%m/%Y")
sismos11 <- sismos[year(fechas) >= 1980,] # Por anio

sismos11$Magnitud <- as.numeric(sismos11$Magnitud) # se generan NAs
sismos22 <- sismos11[!is.na(sismos11$Magnitud),] # Valores validos, es decir, sin NAs

sismos22$Estado2[which(sismos22$Estado2 == " OAx")] <- " OAX"
table(sismos22$Estado2)

# any filtra por
# sismos22$Estado2 == any("OAX", " CHIS", " GRO"," HGO")
sismos33 <- sismos22[sismos22$Estado2 %in% c(" OAX", " CHIS", " GRO"," HGO"),]
table(sismos33$Estado2)

sort(table(sismos33$Estado2), decreasing = TRUE)

table(sismos22$Estado2)[order(table(sismos22$Estado2))]

frecu_tabla <- data.frame(table(sismos22$Estado2))
frecu_tabla[order(frecu_tabla$Freq, decreasing = TRUE),]
frecu_tabla[order(frecu_tabla$Var1, decreasing = TRUE),]

## Box Plot
boxplot(sismos33$Magnitud)
boxplot(Magnitud ~ Estado2, data=sismos33)
boxplot(sismos33$Magnitud ~ sismos33$Estado2, data=sismos33, col = "blue", range=4, horizontal = TRUE)

graficofalso <- boxplot(sismos33$Magnitud ~ sismos33$Estado2, plot = FALSE)
graficofalso$out
graficofalso$stats

# aggregate(numerica~categorica)
sismosHGO <- sismos33[sismos33$Estado2 == ' HGO',]
table(sismosHGO$Magnitud)
library(beeswarm)

beeswarm(sismosHGO$Magnitud, col = 2, cex = 0.9, pch = 18)

hist(sismosHGO$Magnitud, breaks = "Freedman-Diaconis")
hist(sismosHGO$Magnitud)
hist(sismosHGO$Magnitud, breaks = seq(0,5,0.5))
diff(range(sismosHGO$Magnitud))

plot(density(sismosHGO$Magnitud), ylim = c(0,2))
lines(density(sismos33$Magnitud), add = TRUE)

library(car)
densityPlot(sismos33$Magnitud ~ as.factor(sismos33$Estado2),
            legend = list(title = "Estado"))


library(readxl)
turismo <- read_excel("data/Turismo.xlsx", sheet = "Turismo")
turismo

par(fig=c(0,0.7,0,0.7)) #Jugar con este parámetro
plot(turismo$AN, turismo$`S&P`, xlab="AN",
     ylab="S&P")
par(fig=c(0,0.7,0.4,1), new=TRUE)

boxplot(turismo$AN, horizontal=TRUE, axes=FALSE)
par(fig=c(0.65,1,0,0.7),new=TRUE)
boxplot(turismo$`S&P`, axes=FALSE)
mtext("Dispersión + Boxplot", side=3, outer=TRUE, line=-3)
dev.off()

# Grafico 3D
library(scatterplot3d)
scatterplot3d(x = turismo[,2:4], y=turismo$TIC, z=turismo$Precios, color = 1, pch = 3)
scatterplot3d(turismo[,2:4])

library(rgl)
plot3d(x = turismo$AN, y=turismo$TIC, z=turismo$Precios, pch = 3, font = 2)
rglwidget()

library(aplpack)
faces(turismo[,2:6], labels = as.factor(turismo$Pais))
