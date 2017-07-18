library(ggplot2)

fs <- list(function(x) 1,
           function(x) 1 -x,
           function(x) 1 -x +x^2,
           function(x) 1 -x +x^2 -x^3,
           function(x) 1 -x +x^2 -x^3 +x^4,
           function(x) 1 -x +x^2 -x^3 +x^4 -x^5,
           function(x) 1 -x +x^2 -x^3 +x^4 -x^5 +x^6,
           function(x) 1 -x +x^2 -x^3 +x^4 -x^5 +x^6 -x^7,
           function(x) 1 -x +x^2 -x^3 +x^4 -x^5 +x^6 -x^7 +x^8,
           function(x) 1 -x +x^2 -x^3 +x^4 -x^5 +x^6 -x^7 +x^8 -x^9,
           function(x) 1 -x +x^2 -x^3 +x^4 -x^5 +x^6 -x^7 +x^8 -x^9 + x^10)
x <- seq(-3/4, 1, 1/2^10)
df <- data.frame(x, sapply(fs, function(f) f(x))) %>%
    melt(id = "x")
df$variable <- rep(seq(fs), each = length(x))

ggplot(df, aes(x, value,
               group = factor(variable),
               colour = -variable)) +
    geom_line() +
    theme(legend.position = "none") +
    theme_minimal() +
    ylab('f(x)') +
    theme(legend.position = 'none')
