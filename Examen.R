# Sismos
sismos <- read.csv("data/SSNMX_catalogo_19000101_20251004 (1).csv")
sapply(sismos, class)

# Detectamos que hay campos de tipo caracter en la Magnitud
# table(sismos$Magnitud)

# Transformamos a numerico la columna magnitud
sismos$Magnitud <- as.numeric(sismos$Magnitud)

# Obtenermos las etiquetas de los estados de Estado2
table(sismos$Estado2)

# Detectamos que existe OAX y OAx - vamos a emparejarlo con OAX
which(sismos$Estado2 == " OAx")

# Erroes en Oaxaca
sismos$Estado2[which(sismos$Estado2 == " OAx")] <- " OAX"
sismos$Estado2[which(sismos$Estado2 == "OAX")] <- " OAX"

# 32 Entidades - https://es.wikipedia.org/wiki/ISO_3166-2:MX
length(table(sismos$Estado2))

# ¿Cuando (fecha) sucedieron los cinco sismos con mayor intensidad de cada estado?
# Reportar tambien si hay empates en estos.

# Total de Magnitues con NA
length(sismos$Magnitud)

# Limpio Magnitudes NA
sismos_2 <- sismos[sismos$Magnitud[!is.na(sismos$Magnitud)],]
sismos_2
length(sismos_2$Magnitud)

sismos_ordenados <- sismos[order(sismos$Estado2, -sismos$Magnitud),]
sismos_ordenados


# # Enfermedades transmitidas por vectores
# dengue <- read.csv("data/dengue_abierto.csv")
# dengue
# sapply(dengue, class)
#
# # Catalogo Entidad
# library(readxl)
# conv_entidad <- iconv("CATÁLOGO ENTIDAD", from = "latin1", to = "UTF-8")
# catalogo_entidad <- read_excel("data/cat_dengue.xlsx", sheet = conv_entidad)
# catalogo_entidad
#
# # Convertir Clave Entidad a Entero
# catalogo_entidad$CLAVE_ENTIDAD <- as.numeric(catalogo_entidad$CLAVE_ENTIDAD)
#
# # Obtengo una tabla de frecuencias de dengue para ver si coincide con la clave entidad
# table(dengue$ENTIDAD_ASIG)
#
# # Creamos la relacion de la Entidad con la tabla Dengue
# dengue2 <- merge(x = dengue, y = catalogo_entidad, by.x="ENTIDAD_ASIG", by.y = "CLAVE_ENTIDAD", sort = FALSE)
# dengue2
# head(dengue2, 5)