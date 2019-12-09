library(tidyverse)
library(ggplot2)

# plot survival rate by deck level
make_deck_plot <- function() {

        titanic_deck_df = read.csv("data/wrangled_titanic_df.csv")
        titanic_deck_df$deck <- factor(titanic_deck_df$deck, 
                               levels = c( "G", "F", "E", "D", "C", "B", "A"))
        survival_deck <- titanic_deck_df %>%
        group_by(deck) %>%
        summarise(stat = mean(survived))
        
        ggplot(survival_deck, aes(x = deck, y = stat*100)) +
        geom_bar(stat = "identity", 
                 width = 0.5, 
                 color = "blue",
                 fill = "blue") +
        labs(x = "Deck", 
             y = "Rate of Survival (%)", 
             title = "Survival Rate by Deck") +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(),
              panel.background = element_blank(),
              axis.line = element_line(colour = "grey"),
              plot.title = element_text(hjust = 0.5)) +
        coord_flip()
}
