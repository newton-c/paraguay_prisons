library(tidyverse)

map_df <- map_data("world") %>% 
  select(lon = long, lat, group, region, id = subregion)

map <- ggplot() +
  geom_polygon(map_df, mapping = aes(lon, lat, group = group),
               fill = "#E2E3E1",
               colour = ifelse(map_df$region == "Paraguay",
                               "#3B3B3B", "#D0D1CF")) + 
  theme_void() +
  theme(panel.background = element_rect(fill = "#F3F3F3"),
        legend.position = "none",
        plot.title = ggplot2::element_text(family = "Roboto Bold",
                                           size = 24,
                                           color = "#3B3B3B",
                                           hjust = 0),
        plot.subtitle = ggplot2::element_text(family = "Roboto",
                                                    size = 19,
                                                    color = "#3b3b3b",
                                                    margin = ggplot2::margin(9, 0, 20, 0),
                                                    hjust = 0),
        plot.caption = ggplot2::element_blank()#,
        # plot.caption.position = "topleft"
  ) + 
  coord_sf(xlim = c(-67.75, -49), ylim = c(-29, -19)) +
  geom_point(prison_data, mapping = aes(x = lon, y = lat,
                                      fill = total),
             size = prison_data$total / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#4F7264",
             stroke = 1,
             alpha = .7) +
  geom_segment(mapping = aes(x = -65, y = -25.30843,
                             xend = -58.75, yend = -25.30842),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_label(mapping = aes(x = -66.355, y = -26,
                           label = paste("Tacumbú has 2,847",
                                         "prisoners more than",
                                         "half of which haven't",
                                         "had a trial. The",
                                         "official capacity is 1530.",
                          sep = "\n")),
            family = "Roboto Bold",
            size = 4,
            color = "#3B3B3B",
            hjust = "left",
            label.r = unit(0, "lines")) +
  geom_text(mapping = aes(x = -50.75, y = -29, label = 
    "i\u200An\u200As\u200Ai\u200Ag\u200Ah\u200At\u200Ac\u200Ar\u200Ai\u200Am\u200Ae\u200A.\u200Ao\u200Ar\u200Ag"
     ),
    size = 4, family = "Noto Serif", fontface = "italic", color = "#a5a5a5") +
    labs(title = "Incarcerated Individuals\nin Paraguay",
         subtitle = "May 2023")
  
map
