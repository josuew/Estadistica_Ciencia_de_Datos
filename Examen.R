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
media_edades_por_estado <- aggregate(dengue4$EDAD_ANOS ~ dengue4$`DESCRIPCIÓN` + dengue4$ENTIDAD_FEDERATIVA, FUN=mean_and_sd, data = dengue4)

# BoxPlot
# Elaborar un grafico Boxplot donde simultaneamente se compare la edad promedio,
# por sexo, en cada uno de los cinco estados estudiados. ¿Que se puede rescatar de
# lo observado? Realizar una descripcion apropiada de lo observado en el grafico.
boxplot(tabla_promedio$EDAD_ANOS ~ dengue4$ENTIDAD_FEDERATIVA, data = dengue4)
dev.off()