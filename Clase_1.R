5 + 2
5 / 8
5 - 3

x = 5
x <- 5
print(x)

# Marco de Datos
edades <- c(15, 20, 30)
edades
edades[1] # 15
edades[2:3] # 20,30
edades[-1] # 20,30

edades < 25 # TRUE TRUE FALSE

#Generar Matrices
estatura <- c(178, 158, 169)
estatura

# Une por columnas
cbind(edades, estatura)

#Une por filas
rbind(edades, estatura)

# Cada columna tiene un tipo de dato
marco1 <- data.frame(Edades = edades, Estatura = estatura)
marco1["Edades"] # Submatriz
marco1$Estatura # Devuelve el vector de la columna

# dim solo funciona en matrices
dim(marco1) # Dimensiones del marco
dim(marco1["Edades"])

length(marco1$Estatura)

marco1[1, 1] # Fila 1, Columna 1
marco1[1,] # Todas las columnas de la fila 1
marco1[, 1] # Todos los renglones de la columna 1
marco1[2:3, 1] # Elementos 2 y 3 de la columna 1
marco1[2:3, -1] # Elementos 2 y 3 de la columna que no sea 1 es decir la 2

# install.packages("readxl")
# library(readxl)
# read.csv("data/SSNMX_catalogo_19000101_20251004.csv")

# Matrices Manuales
matriz1 <- matrix(data = c(15, 170, 20, 158, 30, 169), ncol = 2, byrow = TRUE)
matriz2 <- matrix(data = c("Juan", "Pedro", "Luis", "Pablo"), ncol = 2, byrow = TRUE)
matriz2

marco2 <- data.frame(Nombres = c("Juan", "Pedro", "Luis"), Edades = c(15, 20, 30))
marco2
marco2["Nombres"]

summary(marco2)

matriz3 <- matrix(data = c(15, 170, 20, 158, 30, 169, 25), ncol = 2, byrow = TRUE)
matriz3

# Numeros a Caracteres, coercion
matriz4 <- matrix(data = c(15, 170, 20, 158, 30, 169, 25, "Hector"), ncol = 2, byrow = TRUE)
matriz4
cat("\n")
matriz4[,2]

cat("\n")
# Caracteres a Numeros
# Importante en el examen
sum(as.numeric(matriz4[,2]), na.rm = TRUE)


