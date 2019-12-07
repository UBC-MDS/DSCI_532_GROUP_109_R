library(ggplot2)
library(tidyverse)
original_titanic <- read.csv("data/titanic.csv")

original_titanic$pclass <- factor(original_titanic$pclass, levels = c("3", "2", "1"))

survival_class <- original_titanic %>% 
  group_by(pclass) %>% 
  summarise(stat = mean(survived))

survival_class

plot <- ggplot(data = survival_class, aes(x = pclass, y = stat)) +
     geom_bar(stat = "identity", width = 0.5, color = "blue", fill = "blue") + 
     theme_minimal() +
     labs(x = "Class", y = "Rate of Survival (%)", title = "Survival Rate by Class") +
     theme(panel.grid.major = element_blank(), 
           panel.grid.minor = element_blank(),
           panel.background = element_blank(),
           axis.line = element_line(colour = "grey"),
           plot.title = element_text(hjust = 0.5)) +
     coord_flip()

plot
