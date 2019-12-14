library(tidyverse)
library(ggplot2)
library(plotly)
library(gridExtra)

make_survived_legend <- function() {
        
        survived_legend <- data.frame(x = c(0, -1),
                                      y = c(0, 0),
                                      z = c("Passenger Survived", ""),
                                      color = c("white", "white"))
        
        chart <- ggplot(survived_legend, aes(x = x, y = y)) +
                geom_point(fill = survived_legend$color,
                           color = "black",
                           shape = 21,
                           size = 3.5,
                           show.legend = FALSE) +
                xlim(0, 12) +
                ylim(0, 0.1) +
                geom_text(label = survived_legend$z,
                          hjust = 0,
                          nudge_x = 1.7) +
                theme(panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(),
                      panel.background = element_blank(),
                      axis.line = element_blank(),
                      axis.text = element_blank(),
                      axis.ticks = element_blank(),
                      axis.title = element_blank())
        
        ggplotly(chart)
        
}

make_survived_legend()

