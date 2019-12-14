library(tidyverse)
library(ggplot2)

make_survival_legend <- function() {

        survival_legend <- data.frame(x = c(0, 2.5),
                                y = c(0, 0),
                                z = c("Passenger Died", "Passenger Survived"),
                                color = c("red", "white"))

        chart <- ggplot(survival_legend, aes(x = x, y = y)) +
                        geom_point(fill = survival_legend$color,
                                   color = "black",
                                   shape = 21,
                                   size = 3.5,
                                   show.legend = FALSE) +
                        xlim(0, 12) +
                        ylim(0, 0.1) +
                        geom_text(label = survival_legend$z,
                                  hjust = 0,
                                  nudge_x = 0.2) +
                        theme(panel.grid.major = element_blank(),
                              panel.grid.minor = element_blank(),
                              panel.background = element_blank(),
                              axis.line = element_blank(),
                              axis.text = element_blank(),
                              axis.ticks = element_blank(),
                              axis.title = element_blank())

chart

}

make_survival_legend()

