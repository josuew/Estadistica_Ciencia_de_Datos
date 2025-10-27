library(readxl)
dengue <- read.csv("data/dengue_abierto.csv")
# dengue
# length(dengue$ID_REGISTRO)

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

# Obtenemos los registros de los Estados:
# Michoacan, Colima, Nayarit, Jalisco y, Guerrero
estados_dengue <- dengue3$ENTIDAD_FEDERATIVA %in% c("MICHOACÁN DE OCAMPO","COLIMA","NAYARIT","JALISCO","GUERRERO")
dengue4 <- dengue3[estados_dengue,]
# dengue4

# sapply(dengue3, class)
mean_and_sd <- function (x){
  c(media = mean(x), desviacion_estandar = sd(x))
}


# aggregate(dengue4$EDAD_ANOS ~ dengue4$`DESCRIPCIÓN` + dengue4$ENTIDAD_FEDERATIVA, FUN=sd, data = dengue4)
# aggregate(dengue4$EDAD_ANOS ~ dengue4$`DESCRIPCIÓN` + dengue4$ENTIDAD_FEDERATIVA, FUN=mean, data = dengue4)
media_edades_por_estado <- aggregate(dengue4$EDAD_ANOS ~ dengue4$ENTIDAD_FEDERATIVA + dengue4$`DESCRIPCIÓN`, FUN=mean_and_sd, data = dengue4)
media_edades_por_estado_ordenado <- media_edades_por_estado[order(media_edades_por_estado$`dengue4$ENTIDAD_FEDERATIVA`),]
media_edades_por_estado_ordenado

# ordenamos por estado

# media_edades_por_estado_ordenado <- do.call(data.frame, media_edades_por_estado_ordenado)
# colnames(media_edades_por_estado_ordenado) <- c("ENTIDAD_FEDERATIVA", "DESCRIPCIÓN", "media", "desviacion_estandar")
median(dengue4$EDAD_ANOS)

# BoxPlot
# Elaborar un grafico Boxplot donde simultaneamente se compare la edad promedio,
# por sexo, en cada uno de los cinco estados estudiados. ¿Que se puede rescatar de
# lo observado? Realizar una descripcion apropiada de lo observado en el grafico.
par(mar = c(5, 10, 4, 2))  # Ajustar márgenes
boxplot(EDAD_ANOS ~ `DESCRIPCIÓN` + ENTIDAD_FEDERATIVA,
        main = "Distribución de Edad por Entidad Federativa y Sexo",
        xlab = "Edad (años)",
        ylab = "",
        data = dengue4,
        horizontal = TRUE,
        las = 1,
        col = c("lightblue", "lightpink"),
        names = rep(c("H", "M"), 5),
        at = c(1, 2, 4, 5, 7, 8, 10, 11, 13, 14))

# Agregar etiquetas de los estados en el eje Y
axis(2, at = c(1.5, 4.5, 7.5, 10.5, 13.5),
     labels = sort(unique(dengue4$ENTIDAD_FEDERATIVA)),
     las = 1, tick = FALSE, line = 1)

legend("topright", legend = c("Hombre", "Mujer"), fill = c("lightblue", "lightpink"))

# Mostrar el grafico de densidad (simultaneos) de cada uno de los cinco estados. Discutir
# lo observado.
library(car)
densityPlot(dengue4$EDAD_ANOS ~ as.factor(dengue4$ENTIDAD_FEDERATIVA),
            legend = list(title="Densidad Edad"))


# Considerando solo el municipio con mayor cantidad de casos de cada estado, comparar
# los graficos de densidad de estos municipios de forma simult´anea (un solo ambiente
# grafico). ¿Que se puede observar?



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
