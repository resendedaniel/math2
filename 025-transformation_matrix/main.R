library(MASS)
library(ggplot2)

P_matrix <- matrix(c(
    1, 0,
    1, 4,
    -3, 4
), 2)
T_matrix <- matrix(c(
    1, -1,
    0, 1
), 2)

T_points <- T_matrix %*% P_matrix

df <- data.frame(t(cbind(P_matrix, T_points)), type=rep(c("original", "translated"), each=3))
names(df)[1:2] <- c("x", "y")

ggplot(df, aes(x, y, fill=type, alpha=0.1)) + geom_polygon()
