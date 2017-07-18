setwd("~/workspace/math2/029-khan")
library(jsonlite)
library(lubridate)
library(reshape2)
library(ggplot2)
library(dplyr)
library(gridExtra)

file <- "response.json"
rawdata <- fromJSON(file)

exercises <- rawdata$students$activity$dictExerciseBuckets
videos <- rawdata$students$activity$dictVideoBuckets

data <- mapply(function(d, n) {
    d <- d[sapply(d, is.data.frame)]
    dates <- names(d)
    dates <- ymd(dates)
    d <- sapply(d, function(e) {
        e$minutes
    })
    d <- data.frame(dates, d, row.names=NULL)
    names(d)[2] <- n

    list(d)
}, d=list(exercises, videos), n=c("exercises", "videos"))

data <- do.call("merge", c(data, all=T))
data[is.na(data)] <- 0

data <- mutate(data, total_exercises = cumsum(exercises)) %>%
    mutate(total_videos = cumsum(videos))

data <- melt(data, id="dates")

g1 <- ggplot(filter(data, variable %in% c("total_exercises", "total_videos")), aes(dates, value / 60, fill=variable)) +
    geom_area(alpha=.75) +
    xlab("") +
    ylab("horas") +
    theme_minimal() +
    theme(legend.position="none")

g2 <- ggplot(filter(data, variable %in% c("exercises", "videos")) %>%
                 group_by(dates) %>%
                 summarise(value = sum(value)), aes(dates, value/60)) +
    geom_point() +
    # geom_smooth(method="lm", se=FALSE) +
    xlab("") +
    ylab("horas de Khan Academy") +
    theme_minimal() +
    theme(legend.position="none")



g3 <- ggplot(filter(data, variable %in% c("exercises", "videos")), aes(value / 60, fill=variable)) +
    geom_histogram(bin=30) +
    facet_wrap(~variable) +
    xlab("horas de Khan Academy") +
    ylab("dias") +
    theme(legend.position="bottom", legend.title=element_blank())

grid.arrange(g1, g2, g3, nrow=3, main="Khan Academy effort/pleasure")

filter(data, variable %in% c("exercises", "videos")) %>%
    group_by(variable) %>%
    summarise(sum(value))
filter(data, variable %in% c("exercises", "videos")) %>%
    group_by(variable) %>%
    summarise(mean(value))
