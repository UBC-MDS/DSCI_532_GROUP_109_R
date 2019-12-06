library(tidyverse)

titanic_df <- read.csv("data/titanic.csv") 
cabin_locations_df = read.csv("data/cabin_locations_df.csv")
titanic_passengers_by_cabin = read.csv("data/wrangled_titanic_df.csv")
cabin_locations_df

#draw ship outline for plot
ship_outline = data.frame(outline_num = c("A", "A", "A", "A", "A", "B", "B", "B", "B", "B", "C", "C"),
                          x = c(305, 325, 470, 475, 477,305, 325, 470, 475, 477, 477, 477), 
                          y= c(3.5, 7, 7, 6, 5, 3.5, 0, 0, 1, 2, 2, 5))

titanic_passengers_by_cabin %>%
  filter(deck == "C") %>%
  ggplot(aes(x = cabin_x, y = cabin_y, color = as.factor(survived))) +
  geom_point() +
  geom_line(data = ship_outline, aes(x = x, y = y, color = outline_num)) +
  geom_point(data = filter(cabin_locations_df, deck == "C"), shape = 0, size = 8,
           aes(x = cabin_x, y = cabin_y, color = deck)) +
  scale_color_manual(values = c("red", "blue", "black", "black", "black")) +
  labs(x = "", y = "", title = "Fate of Titanic Passengers by Cabin Location") +
  theme(plot.title = element_text(hjust = 0.5))
