############################## DENGUE 2024
# Edad promedio por estado de las personas con dengue
# Edad promedio por estado y por sexo de personas con dengue

# install.packages("readxl")
library(readxl)
dengue <- read.csv("data/dengue_abierto.csv")

sheet_name <- iconv("CATÁLOGO SEXO", from = "latin1", to = "UTF-8")
catalo_sexo <- read_excel("data/cat_dengue.xlsx", sheet = sheet_name)

sheet_name2 <- iconv("CATÁLOGO MUNICIPIO", from = "latin1", to = "UTF-8")
catalo_munici <- read_excel("data/cat_dengue.xlsx", sheet = sheet_name2)

sheet_name3 <- iconv("CATÁLOGO ENTIDAD", from = "latin1", to = "UTF-8")
catalo_entidad <- read_excel("data/cat_dengue.xlsx", sheet = sheet_name3)
# catalo_sexo
# dengue$SEXO

dengue2 <- merge(dengue, catalo_sexo, by.x = "SEXO", by.y = "CLAVE") # Union O inner join
table(dengue2$`DESCRIPCIÓN`)
table(dengue2$SEXO, dengue2$`DESCRIPCIÓN`)

catalo_entidad$CLAVE_ENTIDAD <- as.numeric(catalo_entidad$CLAVE_ENTIDAD)

dengue3 <- merge(dengue2, catalo_entidad, by.x = "ENTIDAD_RES", by.y = "CLAVE_ENTIDAD")
table(dengue3$ABREVIATURA)

aggregate(EDAD_ANOS ~ ABREVIATURA, FUN = mean, data = dengue3)
aggregate(EDAD_ANOS ~ ABREVIATURA + `DESCRIPCIÓN`, FUN = mean, data = dengue3)
aggregate(EDAD_ANOS ~ `DESCRIPCIÓN` + ABREVIATURA, FUN = mean, data = dengue3)

#Municipios
catalo_munici$CLAVE_MUNICIPIO <- as.numeric(catalo_munici$CLAVE_MUNICIPIO)
catalo_munici$CLAVE_ENTIDAD <- as.numeric(catalo_munici$CLAVE_ENTIDAD)

dengue4 <- merge(x=dengue3, y=catalo_munici, by.x=c("ENTIDAD_RES","MUNICIPIO_RES"), by.y = c("CLAVE_ENTIDAD", "CLAVE_MUNICIPIO"), sort = FALSE)
dengue4$MUNICIPIO

dengue4$muniunico <- paste0(dengue4$ABREVIATURA, "- ", dengue4$MUNICIPIO)
sort(table(dengue4$muniunico), decreasing = TRUE)[1:10]
sort(table(dengue4$ABREVIATURA), decreasing = TRUE)[1:5]

sum(dengue4[1,15:20]) # 12 significa qe no tiene enfermedad, 11 tiene 1, 10 tiene 2, etc...
comorbilidades <- 12 - rowSums(dengue4[,15:20])
tabla1 <- table(comorbilidades, dengue4$DEFUNCION)

dengue4[which(comorbilidades == 6),]

tabla1
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