library(ggplot2)

# The limit of sin(x) / x @ x = 0 is undefined because 0/0 is undefined
# But it is there accordingly to this Hopital guy

x <- seq(-2*pi, 2*pi, pi/10)
f1 <- list()
f1 <- c(f1, function(x) 2 * sin(x) - sin(2*x))
f1 <- c(f1, function(x) 4 * x^2 - 5*x)
f1 <- c(f1, function(x) sin(x) ^ (1 / log(x)))
f1 <- c(f1, function(x) sin(x) ^ 2 - cos(x) - 1)
f1 <- c(f1, function(x) sqrt(x - 1) - log(x))
f1 <- c(f1, function(x) sqrt(x^2 - 1))
f1 <- c(f1, function(x) (1 - 2 / x) ^ x)
f1 <- c(f1, function(x) sqrt(4 + x) - sqrt(4 - x/2))

f2 <- list()
f2 <- c(f2, function(x) x - sin(x))
f2 <- c(f2, function(x) 1 - 3*x^2)
f2 <- c(f2, function(x) 1)
f2 <- c(f2, function(x) x - pi/2)
f2 <- c(f2, function(x) log(x) * sqrt(x - 1))
f2 <- c(f2, function(x) x)
f2 <- c(f2, function(x) 1)
f2 <- c(f2, function(x) x)

i <- 1
y <- f1[[i]](x) / f2[[i]](x)

df <- data.frame(x, y)
ggplot(df, aes(x, y)) +
    geom_line() +
    geom_point(data = data.frame(x = 0, y = 6), shape="o", size=3) +
    ggtitle("L'Hopital's Rules")
