library(tidyverse)
library(ggplot2)
library(plotly)
library(gridExtra)

make_cabin_survival_plot <- function(deck_level = "C") {
  
  titanic_df <- read.csv("data/titanic.csv") 
  cabin_locations_df = read.csv("data/cabin_locations_df.csv")
  titanic_passengers_by_cabin = read.csv("data/wrangled_titanic_df.csv")
  
  #draw ship outline for plot
  ship_outline = data.frame(outline_num = c("A", "A", "A", "A", "A", "B", "B", "B", "B", "B", "C", "C"),
                            x = c(305, 325, 470, 475, 477,305, 325, 470, 475, 477, 477, 477), 
                            y = c(3.5, 7, 7, 6, 5, 3.5, 0, 0, 1, 2, 2, 5))
  
  chart <- titanic_passengers_by_cabin %>%
    filter(deck == deck_level) %>%
    ggplot(aes(x = cabin_x, y = cabin_y, color = as.factor(survived))) +
    geom_point(size = 3, show.legend = FALSE) +
    theme_minimal() +
    geom_line(data = ship_outline, aes(x = x, y = y, color = outline_num), show.legend = FALSE) +
    geom_point(data = filter(cabin_locations_df, deck == deck_level), shape = 0, size = 8,
               aes(x = cabin_x, y = cabin_y, color = deck), show.legend = FALSE) +
    scale_color_manual(values = c("red", "darkgrey", "black", "black", "black", "black")) +
    labs(x = "", y = "", title = "Fate of Titanic Passengers by Cabin Location") +
    theme(plot.title = element_text(hjust = 0.5),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_blank(),
          axis.text = element_blank(),
          legend.position = "none") 
    
  ggplotly(chart)
}

make_deck_legend <- function(deck_level = "C") {
  
  deck_legend_frame <- data.frame(x = c(0, 0, 4, 4),
                                  y = c(0, 700, 700, 0))
  
  deck_legend_letters = data.frame(x = c(2, 2, 2, 2, 2, 2, 2),
                                   y = c(50, 150, 250, 350, 450, 550, 650),
                                   label = c("G", "F", "E", "D", "C", "B", "A"))
  
  chart <- ggplot() + 
    # frame
    geom_line(data = deck_legend_frame, 
              aes(x, y), 
              colour = "blue") +
    labs(title = "Fate of Titanic Passengers by Cabin Location") +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          plot.title = element_text(hjust = 0.5)) +
    # lines       
    geom_segment(aes(x=0, y=0, xend=4, yend=0), colour="blue") +
    geom_segment(aes(x=0, y=100, xend=4, yend=100), colour="blue") +
    geom_segment(aes(x=0, y=200, xend=4, yend=200), colour="blue") +
    geom_segment(aes(x=0, y=300, xend=4, yend=300), colour="blue") +
    geom_segment(aes(x=0, y=400, xend=4, yend=400), colour="blue") +
    geom_segment(aes(x=0, y=500, xend=4, yend=500), colour="blue") +
    geom_segment(aes(x=0, y=600, xend=4, yend=600), colour="blue") +
    geom_segment(aes(x=0, y=700, xend=4, yend=700), colour="blue") +
    # letters        
    geom_point(data = deck_legend_letters, 
               aes(x, y), 
               alpha = 0) +
    xlim(0, 4) +
    ylim(0, 700) +
    geom_text(data = deck_legend_letters, aes(x, y, label = label)) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          legend.position = "none") +
    #highlight current level
    geom_point(data = deck_legend_letters[deck_legend_letters$label == deck_level, ],
               aes(x = x, y = y), 
               shape = 15,
               size = 12,
               color = "grey",
               alpha = 0.4)
  ggplotly(chart)
}

make_deck_plot <- function() {
  
  titanic_deck_df = read.csv("data/wrangled_titanic_df.csv")
  titanic_deck_df$deck <- factor(titanic_deck_df$deck, 
                                 levels = c( "G", "F", "E", "D", "C", "B", "A"))
  survival_deck <- titanic_deck_df %>%
    group_by(deck) %>%
    summarise(stat = mean(survived))
  
  chart <- ggplot(survival_deck, aes(x = deck, y = stat*100)) +
    geom_bar(stat = "identity", 
             width = 0.5, 
             color = "blue",
             fill = "blue") +
    theme_minimal() +
    labs(x = "Deck", 
         y = "Rate of Survival (%)", 
         title = "Survival Rate by Class and Deck") +
    theme(plot.title = element_text(hjust = 0.5)) +
    coord_flip()
  
  ggplotly(chart)
}


make_class_plot <- function() {
  original_titanic <- read.csv("data/titanic.csv")
  original_titanic$pclass <- factor(original_titanic$pclass, levels = c("3", "2", "1"))

  survival_class <- original_titanic %>% 
    group_by(pclass) %>% 
    summarise(stat = mean(survived))

  chart <- ggplot(data = survival_class, aes(x = pclass, y = stat*100)) +
    geom_bar(stat = "identity", width = 0.5, color = "blue", fill = "blue") + 
    theme_minimal() +
    labs(x = "Class", y = "Rate of Survival (%)", title = "Survival Rate by Class") +
    theme(plot.title = element_text(hjust = 0.5)) +
    coord_flip()
  
  ggplotly(chart)
}

facet_plots1 <- function() {
  plot1 <- make_class_plot()
  plot2 <- make_deck_plot()
  
  subplot(plot1, plot2, nrows = 1, titleX = TRUE, titleY = TRUE)
}

facet_plots2 <- function(deck_level = "C") {
  plot1 <- make_cabin_survival_plot(deck_level)
  plot2 <- make_deck_legend(deck_level)
  
  subplot(plot1, plot2, nrows = 1, widths = c(0.9, 0.1))
  }

make_cabin_survival_plot(deck_level = "D")

