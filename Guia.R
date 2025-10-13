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
round(1.4) # round(x, n): Devuelve el redondeo de x a n decimales.
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