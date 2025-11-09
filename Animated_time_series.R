# Create a gif animation of annual global air and lake water temperature anomalies
# author: Olaf Jensen olaf.p.jensen@gmail.com

# Load necessary libraries
library(ggplot2)
library(gganimate)
library(dplyr)
library(here)
library(gifski)

# Import data
#specify the path using here()
path <- here("data", "Temperature2.csv")
#read in the csv file to a data frame called Temperature
Temperature <- read.csv(path)

# Reshape the data for ggplot2

data <- data.frame(
  Year = Temperature$Year,
  Air = Temperature$Air,
  Lake_Water = Temperature$Water
) %>%
  tidyr::pivot_longer(cols = c(Air, Lake_Water), names_to = "Series", values_to = "Value")


# Create the animated plot
p <- ggplot(data, aes(x = Year, y = Value, color = Series)) +
  geom_line(size = 1.2) +
  labs(title = "Temperature Anomalies (1880 - 2024)", 
       subtitle = "Year: {frame_along}", 
       x = "Year", 
       y = "Anomaly (deg C)", 
       color = "Series") +
  theme_minimal(base_size = 20) +
  transition_reveal(Year) 

# Save the animation
animate(p, duration = 10, fps = 20, width = 800, height = 500, renderer = gifski_renderer("time_series_animation.gif", loop=FALSE))

# Display the animation

p
