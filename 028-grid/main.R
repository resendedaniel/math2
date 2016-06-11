n <- 1080 / 108
x <- seq(-1, 1, length.out=n + 1)
y <- x

alpha <- .25
ggplot(data.frame(x, y), aes(a, y, alpha = alpha)) +
    geom_vline(xintercept = x, alpha = alpha) +
    geom_hline(yintercept = x, alpha = alpha) +
    geom_line(data = data.frame(x, y), aes(x, y)) +
    geom_line(data = data.frame(x, y=-y), aes(x, y)) +
    scale_alpha(range=c(alpha, alpha)) +
    theme_void() +
    theme(legend.position = "none")
