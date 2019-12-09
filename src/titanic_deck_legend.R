library(tidyverse)
library(ggplot2)

# plot deck legend
make_deck_legend <- function(deck_level ='B') {
        
        deck_legend_frame <- data.frame(x = c(0, 0, 10, 10),
                                        y = c(0, 700, 700, 0))
        
        deck_legend_letters = data.frame(x = c(5, 5, 5, 5, 5, 5, 5),
                                         y = c(50, 150, 250, 350, 450, 550, 650),
                                         label = c("G", "F", "E", "D", "C", "B", "A"))
        
        ggplot() + 
                # frame
                geom_line(data = deck_legend_frame, 
                          aes(x, y), 
                          colour = "blue") +
                labs(title = "Deck Levels") +
                theme(panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(),
                      panel.background = element_blank(),
                      axis.line = element_blank(),
                      axis.text = element_blank(),
                      axis.ticks = element_blank(),
                      axis.title = element_blank(),
                      plot.title = element_text(hjust = 0.5)) +
                # lines       
                geom_segment(aes(x=0, y=0, xend=10, yend=0), colour="blue") +
                geom_segment(aes(x=0, y=100, xend=10, yend=100), colour="blue") +
                geom_segment(aes(x=0, y=200, xend=10, yend=200), colour="blue") +
                geom_segment(aes(x=0, y=300, xend=10, yend=300), colour="blue") +
                geom_segment(aes(x=0, y=400, xend=10, yend=400), colour="blue") +
                geom_segment(aes(x=0, y=500, xend=10, yend=500), colour="blue") +
                geom_segment(aes(x=0, y=600, xend=10, yend=600), colour="blue") +
                geom_segment(aes(x=0, y=700, xend=10, yend=700), colour="blue") +
                # letters        
                geom_point(data = deck_legend_letters, 
                           aes(x, y), 
                           alpha = 0) +
                xlim(0, 10) +
                ylim(0, 700) +
                geom_text(data = deck_legend_letters, aes(x, y, label = label)) +
                theme(panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(),
                      panel.background = element_blank(),
                      axis.line = element_blank(),
                      axis.text = element_blank(),
                      axis.ticks = element_blank(),
                      axis.title = element_blank()) +
                #highlight current level
                geom_point(data = deck_legend_letters[deck_legend_letters$label == deck_level, ],
                           aes(x = x, y = y), 
                           shape = 15,
                           size = 18,
                           color = "grey",
                           alpha = 0.4)
}

