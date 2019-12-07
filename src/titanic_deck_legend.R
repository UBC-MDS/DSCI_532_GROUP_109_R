library(tidyverse)
library(ggplot2)


make_deck_legend <- function(deck_level='B') {
        
        #outline
        deck_legend_frame <- data.frame(x = c(0, 0, 10, 10),
                                        y = c(0, 700, 700, 0))
        
        deck_legend_outline <- ggplot(deck_legend_frame, aes(x, y)) +
                geom_line(colour = "blue") +
                labs(title = "Deck Levels") +
                theme(panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(),
                      panel.background = element_blank(),
                      axis.line = element_blank(),
                      axis.text = element_blank(),
                      axis.ticks = element_blank(),
                      axis.title = element_blank(),
                      plot.title = element_text(hjust = 0.5)) +
                geom_segment(aes(x=0, y=0, xend=0, yend=0), colour="blue") +
                geom_segment(aes(x=0, y=100, xend=10, yend=100), colour="blue") +
                geom_segment(aes(x=0, y=200, xend=10, yend=200), colour="blue") +
                geom_segment(aes(x=0, y=300, xend=10, yend=300), colour="blue") +
                geom_segment(aes(x=0, y=400, xend=10, yend=400), colour="blue") +
                geom_segment(aes(x=0, y=500, xend=10, yend=500), colour="blue") +
                geom_segment(aes(x=0, y=600, xend=10, yend=600), colour="blue") +
                geom_segment(aes(x=0, y=700, xend=10, yend=700), colour="blue") 
        
        #labels
        legend_letters = data.frame(x = c(5, 5, 5, 5, 5, 5, 5),
                                   y = c(50, 150, 250, 350, 450, 550, 650),
                                   label = c("G", "F", "E", "D", "C", "B", "A"))
        
        deck_legend_levels <- ggplot(legend_letters, aes(x, y, label = label )) +
                geom_point(alpha = 0) +
                xlim(0, 10) +
                ylim(0, 700) +
                geom_text() +
                theme(panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(),
                      panel.background = element_blank(),
                      axis.line = element_blank(),
                      axis.text = element_blank(),
                      axis.ticks = element_blank(),
                      axis.title = element_blank())
        deck_legend_levels
        
        #highlight current level
        deck_legend_current_level <- ggplot(legend_letters[legend_letters$label == deck_level, ], aes(x, y)) +
                geom_point(shape = c, 
                           size = 20, 
                           color = "grey")

        #combine outline, levels and current level

        
}

make_deck_legend()