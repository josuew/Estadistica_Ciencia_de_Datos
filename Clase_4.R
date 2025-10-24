############################## DENGUE 2024
# Edad promedio por estado de las personas con dengue
# Edad promedio por estado y por sexo de personas con dengue

# install.packages("readxl")
library(readxl)
dengue <- read.csv("data/dengue_abierto.csv")

# Un archivo xlsx se debe de leer pestana tras pestana
# Se utiliza la libreria "readxl"

# Aqui se especifica que hoja leer
conv_sexo <- iconv("CATÁLOGO SEXO", from = "latin1", to = "UTF-8")
catalo_sexo <- read_excel("data/cat_dengue.xlsx", sheet = "CATÁLOGO SEXO")
catalo_sexo

# catalo_sexo
# dengue$SEXO

# El primer campo toma la tabla que contiene la numeracion en la tabla
# El segundo campo es de donde va a crear la relacion de las etiquetas con los numeros
# by.x toma las columna de X de la tabla Dengue que contiene los numeros y by.y contiene la columna y con la relacion de los campos
dengue2 <- merge(dengue, catalo_sexo, by.x = "SEXO", by.y = "CLAVE") # INNER JOIN = merge

# Al realizar el merge se agregan las columnas de la sheet "CATÁLOGO SEXO" en la tabla dengue2
colnames(dengue2)

table(dengue2$`DESCRIPCIÓN`)
table(dengue2$SEXO, dengue2$`DESCRIPCIÓN`)

#Catalogo Entidad
# En este ejemplo la columna CLAVE_ENTIDAD parece numerica pero es "text"
conv_entidad <- iconv("CATÁLOGO ENTIDAD", from = "latin1", to = "UTF-8")
catalo_entidad <- read_excel("data/cat_dengue.xlsx", sheet = "CATÁLOGO ENTIDAD")
catalo_entidad

# Convertimos la columna CLAVE_ENTIDAD a numerica para empatarla con ENTIDAD_RES que es numerica
catalo_entidad$CLAVE_ENTIDAD <- as.numeric(catalo_entidad$CLAVE_ENTIDAD)
catalo_entidad

# Agregamos las columnas de la sheet "CATÁLOGO ENTIDAD" en la tabla que unimos con "CATÁLOGO SEXO"
dengue3 <- merge(dengue2, catalo_entidad, by.x = "ENTIDAD_RES", by.y = "CLAVE_ENTIDAD")
dengue3
colnames(dengue3)

table(dengue3$ABREVIATURA)

# 1:31:36
# Edad anos de las personas respecto a la abreviatura
aggregate(EDAD_ANOS ~ ABREVIATURA, FUN = mean, data = dengue3)
# Dentro del estado los sexos
aggregate(EDAD_ANOS ~ ABREVIATURA + `DESCRIPCIÓN`, FUN = mean, data = dengue3)
# Dentro de los sexos cada estado
aggregate(EDAD_ANOS ~ `DESCRIPCIÓN` + ABREVIATURA, FUN = mean, data = dengue3)

#Municipios
conv_municipio <- iconv("CATÁLOGO MUNICIPIO", from = "latin1", to = "UTF-8")
catalo_munici <- read_excel("data/cat_dengue.xlsx", sheet = "CATÁLOGO MUNICIPIO")

catalo_munici$CLAVE_MUNICIPIO <- as.numeric(catalo_munici$CLAVE_MUNICIPIO)
catalo_munici$CLAVE_ENTIDAD <- as.numeric(catalo_munici$CLAVE_ENTIDAD)
catalo_munici


dengue4 <- merge(x=dengue3, y=catalo_munici, by.x=c("ENTIDAD_RES","MUNICIPIO_RES"), by.y = c("CLAVE_ENTIDAD", "CLAVE_MUNICIPIO"), sort = FALSE)
dengue4
colnames(dengue4)

dengue4$MUNICIPIO

# Genera la columna
dengue4$muniunico <- paste0(dengue4$ABREVIATURA, " - ", dengue4$MUNICIPIO)
dengue4$muniunico
colnames(dengue4)

# Estados - Municipio con mayores numeros de dengue
sort(table(dengue4$muniunico), decreasing = TRUE)[1:10]

# Estados con mayores numeros de dengue
sort(table(dengue4$ABREVIATURA), decreasing = TRUE)[1:5]

colnames(dengue4)[15:20]
sum(dengue4[1,15:20]) # 12 significa que no tiene enfermedad, 11 tiene 1, 10 tiene 2, etc...

# rowSums suma por renglones
comorbilidades <- 12 - rowSums(dengue4[,15:20])
tabla1 <- table(comorbilidades, dengue4$DEFUNCION)
tabla1

dengue4[which(comorbilidades == 6),]

prop.table(tabla1,1) # Proporciones por fila
prop.table(tabla1,2) # Proporciones por columna

# Meses con mayor cantidad de casos de dengue
dengue$FECHA_SIGN_SINTOMAS
fecha_sint <- as.Date(dengue4$FECHA_SIGN_SINTOMAS, tryFormats = "%d/%m/%Y")
library("lubridate")
dengue$meses <- month(dengue$FECHA_SIGN_SINTOMAS, label = TRUE) # Sacar mes
sort(table(dengue$meses), decreasing = TRUE)

#Graficacion
tabla_estados <- data.frame(table(dengue4$ABREVIATURA))
dim(tabla_estados)
barplot(tabla_estados[1:10,2], names.arg = tabla_estados[1:10,1])