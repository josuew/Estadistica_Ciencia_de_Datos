library(readxl)
dengue <- read.csv("data/dengue_abierto.csv")
length(dengue$ID_REGISTRO)

catalogo_entidad <- read_excel("data/cat_dengue.xlsx", sheet = "CATÁLOGO ENTIDAD")
# catalogo_entidad

# Convertir Catalogo Entidad a Numerico
# sapply(catalogo_entidad, class) # CLAVE_ENTIDAD es de tipo "character"
catalogo_entidad$CLAVE_ENTIDAD <- as.numeric(catalogo_entidad$CLAVE_ENTIDAD) # conversion a numerico
# sapply(catalogo_entidad, class)
# catalogo_entidad

# Union de ENTIDAD_FEDERATIVA con ENTIDAD_RES
dengue2 <- merge(dengue,catalogo_entidad, by.x = "ENTIDAD_RES", by.y = "CLAVE_ENTIDAD")
# dengue2$ENTIDAD_FEDERATIVA[is.na(dengue2$ENTIDAD_FEDERATIVA)]

# Union de CATÁLOGO SEXO con SEXO
catalogo_sexo <- read_excel("data/cat_dengue.xlsx", sheet = "CATÁLOGO SEXO")
# sapply(catalogo_sexo, class)

dengue3 <- merge(dengue2, catalogo_sexo, by.x = "SEXO", by.y = "CLAVE")

# Union de CLAVE_MUNICIPIO
catalogo_municipio <- read_excel("data/cat_dengue.xlsx", sheet = "CATÁLOGO MUNICIPIO")
catalogo_municipio[catalogo_municipio$CLAVE_ENTIDAD == "USA", 3] <- "33"
catalogo_municipio[catalogo_municipio$CLAVE_ENTIDAD == "ALTN", 3] <- "34"
catalogo_municipio[catalogo_municipio$CLAVE_ENTIDAD == "OTROS", 3] <- "35"

# sapply(catalogo_municipio, class)
catalogo_municipio$CLAVE_ENTIDAD <- as.numeric(catalogo_municipio$CLAVE_ENTIDAD)
catalogo_municipio$CLAVE_MUNICIPIO <- as.numeric(catalogo_municipio$CLAVE_MUNICIPIO)
# length(catalogo_municipio$CLAVE_MUNICIPIO) # 2503

dengue4 <- merge(x = dengue3, y = catalogo_municipio, by.x = c("ENTIDAD_RES","MUNICIPIO_RES"), by.y = c("CLAVE_ENTIDAD", "CLAVE_MUNICIPIO"), sort=FALSE)
# length(dengue4$ID_REGISTRO) # 550,247

# Agregamos una columna con meses de registro
library(lubridate)
dengue4$FECHA_SIGN_SINTOMAS <- as.Date(dengue4$FECHA_SIGN_SINTOMAS, tryFormats = "%d/%m/%y")
dengue4$DIA_SIGN_SINTOMAS <- day(dengue4$FECHA_SIGN_SINTOMAS)
dengue4$MES_SIGN_SINTOMAS <- month(dengue4$FECHA_SIGN_SINTOMAS)
dengue4$ANIO_SIGN_SINTOMAS <- year(dengue4$FECHA_SIGN_SINTOMAS)

tabla_dengue <- dengue4

# Obtenemos los registros de los Estados:
# Michoacan, Colima, Nayarit, Jalisco y, Guerrero
estados_dengue <- tabla_dengue$ENTIDAD_FEDERATIVA %in% c("MICHOACÁN DE OCAMPO","COLIMA","NAYARIT","JALISCO","GUERRERO")
info_estados_dengue <- tabla_dengue[estados_dengue,]

# Respecto a la edad de los pacientes reportados, elaborar una tabla donde se resuma la
# edad promedio y desviacion estandar, por sexo, de cada uno de los estados anteriormente
# mencionados.
media_y_desviacion_estandar <- function (x){
  c(media = mean(x), desviacion_estandar = sd(x))
}

# aggregate(dengue4$EDAD_ANOS ~ dengue4$`DESCRIPCIÓN` + dengue4$ENTIDAD_FEDERATIVA, FUN=sd, data = dengue4)
# aggregate(dengue4$EDAD_ANOS ~ dengue4$`DESCRIPCIÓN` + dengue4$ENTIDAD_FEDERATIVA, FUN=mean, data = dengue4)
media_edades <- aggregate(info_estados_dengue$EDAD_ANOS ~ info_estados_dengue$ENTIDAD_FEDERATIVA + info_estados_dengue$`DESCRIPCIÓN`, FUN=media_y_desviacion_estandar, data = info_estados_dengue)
media_edades <- media_edades[order(media_edades$`info_estados_dengue$ENTIDAD_FEDERATIVA`),]
media_edades

# aggregate(info_estados_dengue$EDAD_ANOS ~ info_estados_dengue$ENTIDAD_FEDERATIVA + info_estados_dengue$`DESCRIPCIÓN`, FUN = median)
# Elaborar un grafico Boxplot donde simultaneamente se compare la edad promedio,
# por sexo, en cada uno de los cinco estados estudiados. ¿Que se puede rescatar de
# lo observado? Realizar una descripcion apropiada de lo observado en el grafico.
par(mar = c(5, 10, 4, 2))
boxplot(EDAD_ANOS ~ `DESCRIPCIÓN` + ENTIDAD_FEDERATIVA,
        main = "Distribución de Edad por Entidad Federativa y Sexo",
        xlab = "Edad (años)",
        ylab = "",
        data = info_estados_dengue,
        horizontal = TRUE,
        las = 1,
        col = c("lightblue", "lightpink"),
        names = rep(c("H", "M"), 5),
        at = c(1, 2, 4, 5, 7, 8, 10, 11, 13, 14))

# Agregar etiquetas de los estados en el eje Y
axis(2, at = c(1.5, 4.5, 7.5, 10.5, 13.5),
     labels = sort(unique(info_estados_dengue$ENTIDAD_FEDERATIVA)),
     las = 1, tick = FALSE, line = 1)
legend("topright", legend = c("Hombre", "Mujer"), fill = c("lightblue", "lightpink"))

# Mostrar el grafico de densidad (simultaneos) de cada uno de los cinco estados. Discutir
# lo observado.
library(car)
densityPlot(info_estados_dengue$EDAD_ANOS ~ as.factor(info_estados_dengue$ENTIDAD_FEDERATIVA),
            legend = list(title="Densidad Edad"))

# Considerando solo el municipio con mayor cantidad de casos de cada estado, comparar
# los graficos de densidad de estos municipios de forma simultanea (un solo ambiente
# grafico). ¿Que se puede observar?
estados_registro_municipio <- aggregate(info_estados_dengue$ID_REGISTRO ~ info_estados_dengue$ENTIDAD_FEDERATIVA + info_estados_dengue$MUNICIPIO , FUN = length)
colnames(estados_registro_municipio) <- c("Estado", "Municipio", "Registros")
estados_registro_municipio
maximos_por_estado <- do.call(rbind, by(estados_registro_municipio, estados_registro_municipio$Estado, function(df) {
  df[which.max(df$Registros),]
}))
rownames(maximos_por_estado) <- NULL
sapply(maximos_por_estado, class)

info_municipios_max <- info_estados_dengue[
  paste(info_estados_dengue$ENTIDAD_FEDERATIVA, info_estados_dengue$MUNICIPIO) %in%
  paste(maximos_por_estado$Estado, maximos_por_estado$Municipio),
]

densityPlot(info_municipios_max$EDAD_ANOS ~ as.factor(info_municipios_max$MUNICIPIO),
            main = "Distribución de Edad en Municipios con Mayor Casos por Estado",
            xlab = "Edad (años)",
            legend = list(title = "Municipio"))

# Mostrar un grafico de barras, de cada estado, donde muestre la frecuencia de registro
# de nuevos casos de los meses enero a septiembre.

dengue3$FECHA_SIGN_SINTOMAS <- as.Date(dengue3$FECHA_SIGN_SINTOMAS, tryFormats = "%d/%m/%Y")
library(lubridate)
dengue3$MES <- month(dengue3$FECHA_SIGN_SINTOMAS)
dengue3$MES
dengue5<-dengue3[dengue3$MES >= 1 & dengue3$MES <= 9,]
table(dengue5$ENTIDAD_FEDERATIVA)

# Grafico de Barras
dengue_jal <- dengue5[which(dengue5$ENTIDAD_FEDERATIVA == "JALISCO"),]
table(dengue_jal$MES)
res <- aggregate(dengue_jal$FECHA_SIGN_SINTOMAS ~ dengue_jal$MES, FUN=length)
# with(res, hist(rep(x = res$`dengue_jal$MES`, times = res$`dengue_jal$FECHA_SIGN_SINTOMAS`)))
barplot(res$`dengue_jal$FECHA_SIGN_SINTOMAS` ~ res$`dengue_jal$MES`, xlab = "Meses", ylab = "Registro", names.arg = c("1","2","3","4","5","6","7","8","9"),)
# axis(side = 1, at = seq_along(res$`dengue_jal$MES`), labels = res$`dengue_jal$MES`, las = 2)
# aggregate(month(dengue5$FECHA_SIGN_SINTOMAS) ~ dengue5$ENTIDAD_FEDERATIVA, FUN=length)
# hist(dengue3$FECHA_SIGN_SINTOMAS)
