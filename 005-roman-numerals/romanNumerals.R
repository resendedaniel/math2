# Simple plots with roman numerals
library(ggplot2)
library(gridExtra)
library(dp)

x <- 1:3899
arabicLength <- nchar(as.character(x))
romanLength <- nchar(as.character(as.roman(x)))


df <- data.frame(x,
                 romanLength,
                 arabicLength)


g0 <- ggplot(df, aes(x, romanLength)) +
    geom_point(col="darkblue", alpha=.75) +
    theme_minimal() +
    geom_line(data= df, aes(x, arabicLength),
              colour = "darkred",
              size = 2,
              alpha = .75)
g00 <- g0 +
    coord_cartesian(xlim = c(0, 120))

g1 <- g0 +
    xlab("") +
    ylab("roman length")

g2 <- g0 +
    xlab("") +
    ylab("roman length") +
    scale_x_log10()

grid.arrange(g1, g2, nrow=2, top="Roman Numerals Length")

# png("img/linear.png", 1440, 900)
# g1 + ggtitle("Roman Numerals Length")
# dev.off()
#
# png("img/log.png", 1440, 900)
# g2 + ggtitle("Roman Numerals Length - Log Scale")
# dev.off()
#
#
# ## Smooth
# png("img/linear_smooth.png", 1440, 900)
# g1 + ggtitle("Roman Numerals Length") + geom_smooth()
# dev.off()
#
# png("img/log_smooth.png", 1440, 900)
# g2 + ggtitle("Roman Numerals Length - Log Scale") + geom_smooth()
# dev.off()
