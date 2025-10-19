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

# --- Conversion de Caracter a Entero ---
# Convierte el dato de x al tipo numeric siempre que sea posible o
# tenga sentido la conversión. Para convertir una cadena en un número,
# la cadena tiene que representar un número.
# El valor lógico TRUE se convierte en 1 y el FALSE en 0.
print("Conversion de Caracter a Numeric")
numero <- "23"
print(cat(as.numeric(numero), " ", typeof(as.numeric(numero))))
print(cat(as.numeric("23a"), " ", typeof(as.numeric("23a")))) # retorna NA
as.integer("23")
as.double("23.12")

# Convierte el tipo de dato de x al tipo lógico. Para datos numéricos,
# el 0 se convierte en FALSE y cualquier otro número en TRUE.
# Para cadenas se obtiene NA excepto para las cadenas "TRUE" y
# "true" que se convierten a TRUE y las cadenas "FALSE" y "false"
# que se convierten a FALSE.
as.logical("TRUE")


#--- Operaciones con R. R como una calculadora lógica. ---
5 + 5
5 - 2
5 / 2
5 * 5
5 %% 2 # Devuelve el modulo de la división entera de x e y.
2^3 # Devuelve la potencia x elevado a y.

# --- Operadores relacionales ---
1 == 1 # Devuelve TRUE si el número x es igual que el número y, y FALSE en caso contrario.
2 > 1 # x > y: Devuelve TRUE si el número x es mayor que el número y, y FALSE en caso contrario.
1 < 2 # x < y: Devuelve TRUE si el número x es menor que el número y, y FALSE en caso contrario.
1 >= 0 # x >= y: Devuelve TRUE si el número x es mayor o igual que el número y, y FALSE en caso contrario.
2 <= 3 # x <= y: Devuelve TRUE si el número x es menor o igual a que el número y, y FALSE en caso contrario.
2 != 3 # x != y: Devuelve TRUE si el número x es distinto del número y, y FALSE en caso contrario.

# --- Funciones y constantes numéricas ---
pi # pi: Devuelve el número 𝜋.
sqrt(9) # sqrt(x): Devuelve la raíz cuadrada de x.
# El valor absoluto de un numero es el valor del numero sin signo
abs(-2) # abs(x): Devuelve el valor absoluto de x.
# El redondeo funciona apartir de .5 de lo contrario se trunca
round(1.4) # round(x, n): Devuelve el redondeo de x a n decimales. Apartir de .5
round(1.5) # round(x, n): Devuelve el redondeo de x a n decimales. Apartir de .5
ceiling(1.4)  # Redondea hacia arriba independientemente de que decimal sea
trunc(1.5) # Trunca hacia abajo independientemente de que decimal sea
exp(1) # exp(x): Devuelve la exponencial de x (𝑒𝑥).
log(10) # log(x): Devuelve el logaritmo neperiano de x.
sin(10) # sin(x): Devuelve el seno del ángulo x en radianes.
cos(10) # cos(x): Devuelve el coseno del ángulo x en radianes.
tan(10) # tan(x): Devuelve la tangente del ángulo x en radianes.
asin(10) # asin(x): Devuelve el arcoseno de x.
acos(10) # acos(x): Devuelve el arcocoseno de x.
atan(10) # atan(x): Devuelve el arcotangente de x.


# --- Funciones para cadenas de caracteres ---
nchar("Hola") # Devuelve el número de caracteres de la cadena.
paste("Hola", "Mundo") #Concatena las cadenas x, y, etc. separándolas por la cadena s. Por defecto la cadena de separación es un espacio en blanco.
substr("Hola Mundo", start = 1, stop =4) # Devuelve la subcadena de la cadena c desde la posición i hasta la posición j. El primer carácter de una cadena ocupa la posición 1.
tolower("Hola Mundo") # tolower(c): Devuelve la cadena que resulta de convertir la cadena c a minúsculas.
toupper("Hola Mundo") # Devuelve la cadena que resulta de convertir la cadena c a mayúsculas.

# --- Tipos de datos estructurados ---

# --- Creacion de vectores ---
# Funcion de combinacion c()
arreglo <- c(1,2,3,4) # Devuelve el vector formado por los elementos x1, x2, etc. También es posible utilizar el operador : para generar un vector de números enteros consecutivos:
arreglo_consecutivos <- 1:4 # Devuelve el vector de números enteros consecutivos desde x hasta y.
arreglo_consecutivos

# Etiquetas en los elementos del arreglo
arreglo_etiquetas <- c(el1=1,el2=2,el3=3)
arreglo_etiquetas
names(arreglo_etiquetas) # Devuelve un vector de cadenas de caracteres con los nombres de los elementos del vector x.

# --- Acceso a los elementos de un vector ---
# Un indice puede ser un entero o un caracter dentro de corchetes
# Cuando se utiliza un índice lógico, se obtienen los elementos correspondientes a las posiciones donde está el valor booleano TRUE.
arreglo <- c(1,2,3,4)
arreglo[arreglo > 2]

# --- Pertenencia de un elemento en un vector ---
arreglo <- c(1,2,3,4)
2 %in% arreglo

# --- Modificación de los elementos de un vector ---
arreglo <- c(1,2,3,4)
arreglo[1] <- 0
arreglo

# --- Añadir elementos a un vector ---
arreglo <- c(1,2,3,4)
arreglo <- c(arreglo, 5)
arreglo
arreglo <- append(arreglo, 0, after = 1)
arreglo

# --- Eliminar / Omitir elementos de un vector ---
arreglo <- c(1,2,3,4)
arreglo <- arreglo[-1]
arreglo
rm(arreglo) # Eliminar un vector
arreglo

# --- Operaciones aritméticas con vectores ---
# Si los vectores tienen distinto tamaño, el tamaño del vector más pequeño
# se equipara al tamaño del mayor, reutilizando sus elementos,
# empezando por el primero.
arreglo <- c(1,2,3)
arreglo2 <- c(3,4)
arreglo + arreglo2

# --- Listas ---
# Las listas son colecciones ordenadas de elementos que pueden ser de distintos tipos.

#--- Creacion de Lista ---
list(1,"a,",2,"b",3,"c")

# Al igual que con los vectores, es posible asignar un nombre a cada uno de los elementos de una lista.
list(el1=1,el2="a",el3=2,el4="b",el5=3,el6="c")

# elementos de la lista
length(list(1,2,3))

# Acceso a los elementos de una lista
lista <- list(el1=1,el2="a",el3=2,el4="b",el5=3,el6="c")
lista[1] # Obtiene el elemento 1
lista["el1"] # Obtiene el elemento el1
lista[lista >= 1] # Indice logico

# --- Modificación de los elementos de una lista ---
lista <- list(el1=1,el2="a",el3=2,el4="b",el5=3,el6="c")
lista$el1 <- 0
lista

lista[[1]] <- 1 # por indice
lista

# --- Añadir elementos a una lista ---
lista <- list("nombre" = "Maria", "edad" = 22)
lista$email <- "maria@gmail.com"
lista
lista <- append(lista, list("amigos" = 10))
lista

# --- Matrices ---
# matrix(x, nrow = m, ncol = n): Devuelve la matriz con los elementos del vector x
# organizados en n filas y m columnas. Habitualmente basta con especificar el
# número de filas o el número de columnas.
matrix(data = c(1,2), nrow = 2, ncol = 2) # Los elementos se almacenan en columnas por defecto

matrix(data = c(1,2), nrow = 2, ncol = 2, byrow = TRUE) # Los elementos se almacenan en filas

# Es posible poner nombres a las filas y a las columnas de una matriz añadiendo el parámetro
# dimnames y pasándole una lista de dos vectores de cadenas con los nombres de las filas
# y las columnas respectivamente.
matrix(data = list(c(1,2,3),c(4,5,6)), dimnames = list(c("fila1","fila2","fila3"),c("colA","colB","colC")))