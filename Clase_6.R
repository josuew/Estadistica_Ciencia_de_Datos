# Distribuciones de Probabilidad
# n = 50, p = 0.3

# P(X = 10) + P(X = 11) ... P(X = 40)
# ?pbinom()
# ?qbinom()
# P (10 <= X <= 40)

# P(X< = 40)
pbinom(q = 40, size = 50, prob = 0.3) # Probabilidad de hasta 40 Fumadores
# P(X< = 40) - P(X <= 9) | P(X<=40)-P(X<10)
pbinom(q = 40, size = 50, prob = 0.3, lower.tail = TRUE) -
pbinom(q = 9, size = 50, prob = 0.3, lower.tail = TRUE)
# 95.97% es muy probable tener entre 10 y 40%
# Cual es el valor esperado de fumadores?
50 * 0.3

# P(X>=25) = P(X=25) + P(X=26) + ... + P(X=50)
# P(X >= x), x = 25
# P(X=1) + P(X=2)+...+P(X=25), n = 50
# Acumulada
# 1 - P(X <= 24)
# P(X <= 24) + P(X>=25) = 1
# P(X<=24) = 1 - P(X>=25) =  1 - P(X < 25)
1 - pbinom(q=24, size=50, prob = 0.3)
pbinom(q=24, size=50, prob = 0.3, lower.tail = FALSE)

choose(50,25)
choose(4,2)