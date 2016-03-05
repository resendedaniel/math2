library(ggplot2)

# The limit of sin(x) / x @ x = 0 is undefined because 0/0 is undefined
# But it is there accordingly to this Hopital guy

x <- seq(-6, 6, .01)
y <- sin(x) / x

df <- data.frame(x, y)
ggplot(df, aes(x, y)) +
    geom_line() +
    geom_point(data = data.frame(x = 0, y = 1), shape="o", size=3) +
    ggtitle("L'Hopital's Rule")
