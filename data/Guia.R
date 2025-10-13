
entero <- 1
print(cat("El numero ", entero, " es de tipo ", class(entero))) # integer

doble <- 1.11
print(cat("El numero ", doble, " es de tipo ", class(doble))) # double

caracter <- "a"
print(cat("El caracter ", caracter, " es de tipo ", class(caracter)))

booleano <- TRUE
print(cat("El booleano ", booleano, " es de tipo ", class(booleano)))

# Funciones Booleanas
#Permite saber si el valor es de tipo `numeric`
print("\nFunciones Booleanas")
print(cat("is.numeric: ", is.numeric(entero)))
print(cat("is.double: ", is.numeric(doble)))
print(cat("is.character: ", is.character(doble)))
print(cat("is.logical: ", is.logical(doble)))
print(cat("is.na: ", is.na(doble))) # Verifica si es NA
print(cat("is.na: ", is.null(NULL)))

# Conversión de tipos
