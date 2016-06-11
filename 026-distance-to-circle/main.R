library(ggplot2)
library(dplyr)

# plot circle
circle <- function(angle, band=1.3) {
    x <- band ^ angle
    y0 <- band / x
    y1 <- (1/band) / x

    # y0 <- min(y0, band)
    # y1 <- max(y1, 1/band)

    matrix(c(x, x, y0, y1), 2)
}
angle <- seq(-2, 2, length = 101)
circle_df <- lapply(angle, circle)
circle_df <- do.call(rbind, circle_df)
circle_df <- data.frame(circle_df)
names(circle_df) <- c("x", "y")
circle_df <- circle_df %>%
    mutate(band = rep(c("upper", "lower"), length(angle))) %>%
    filter(!is.nan(y))

# generate point
point <- c(rnorm(1, .9, .45),
           rnorm(1, 2.15, .45))

calc_distance <- function(point) {
    x <- point[1]
    y <- point[2]

    (circle_df$x - x) ^ 2 + (circle_df$y - y) ^ 2
}

n_top <- 20
distances <- calc_distance(point)
closest_ind <- order(distances)[seq(n_top)]
closest_df <- circle_df[closest_ind, ] %>%
    mutate(xend = point[1]) %>%
    mutate(yend = point[2]) %>%
    mutate(distance = distances[closest_ind])

ggplot(circle_df, aes(x, y)) +
    geom_path(aes(group=band), linetype="dashed") +
    geom_hline(aes(yintercept=1), alpha=.25) +
    geom_vline(aes(xintercept=1), alpha=.25) +
    scale_x_continuous(breaks = round(as.numeric(unlist(options()$trades_threshold)), 2)) +
    scale_y_continuous(breaks = round(as.numeric(unlist(options()$trades_threshold)), 2)) +
    theme(panel.grid.minor = element_blank())
    # scale_y_log10() +
    # scale_x_log10()
# + geom_point(data = data.frame(x = point[1],
#                                  y = point[2]),
#                aes(x, y)) +
#     geom_segment(data = closest_df, aes(x=x, y=y, xend=xend, yend=yend, alpha = 1/distance)) +
#     theme_bw() +
#     theme(legend.position = "none")
