tau <- 2 * pi
sides <- c(330, 4, 23, 4, 500, 330, 406, 115, 92, 160, 250, 193, 105, 92)
rad <- c(0, pi/2, 0, -pi/2, 0, pi/2, pi, pi/2, pi, -pi/2, pi, -pi/2, pi, -pi/2)

x <- cumsum(round(c(0, cos(rad) * sides), 4))[-(length(sides)+1)]
xend <- cumsum(round(cos(rad) * sides, 4))

y <- cumsum(round(c(0, sin(rad) * sides), 4))[-(length(sides)+1)]
yend <- cumsum(round(sin(rad) * sides, 4))

df <- data.frame(x, xend, y, yend)

ggplot(df, aes(x, y, xend, yend)) + geom_segment(aes(x=x, y=y, xend=xend, yend=yend))
