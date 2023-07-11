library(tidyverse)

map_df <- map_data("world") %>% 
  select(lon = long, lat, group, region, id = subregion)

data_labels <-  tibble(x = c(-60, -50, -62, -65),
                      y = c(-22, -21, -29, -20),
                      label = c("Paraguay", "Brazil", "Argentina", "Bolivia"))

map <- ggplot() +
  geom_polygon(map_df, mapping = aes(lon, lat, group = group),
               #fill = "#E2E3E1",
               fill = ifelse(map_df$region == "Paraguay",
                               "#E2E3E1", "#F3F3F3"),
               colour = ifelse(map_df$region == "Paraguay",
                               "#3B3B3B", "#D0D1CF")) + 
  theme_void() +
  theme(#panel.background = element_rect(fill = "#F3F3F3"),
        plot.background = element_rect(fill = "#F3F3F3"),
        panel.border = element_blank(),
        legend.position = "none",
        plot.title = ggplot2::element_text(family = "Roboto Bold",
                                           size = 24,
                                           color = "#3B3B3B",
                                           hjust = 0),
        plot.subtitle = ggplot2::element_text(family = "Roboto",
                                              size = 19,
                                              color = "#3b3b3b",
                                              margin = ggplot2::margin(9, 0,
                                                                       20, 0),
                                              hjust = 0),
        plot.caption = ggplot2::element_blank()) + 
  coord_sf(xlim = c(-67, -49.75), ylim = c(-29, -19)) +
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
                                         "prisoners, more than",
                                         "half of which haven't",
                                         "had a trial. The",
                                         "official capacity is 1,530.",
                          sep = "\n")),
            family = "Roboto Bold",
            size = 4,
            color = "#3B3B3B",
            hjust = "left",
            label.r = unit(0, "lines"),
            label.padding = unit(0.5, "lines"),
            lineheight = .85) +
  geom_text(data_labels,
            mapping = aes(x = x,
                          y = y,
                          label = label),
            family = "Roboto Bold", size = 4,
            color = ifelse(data_labels$label == "Paraguay",
                           "#3B3B3B", "#B3B3B3")) +
  geom_text(mapping = aes(x = -51.5, y = -29, label = 
    "i\u200An\u200As\u200Ai\u200Ag\u200Ah\u200At\u200Ac\u200Ar\u200Ai\u200Am\u200Ae\u200A.\u200Ao\u200Ar\u200Ag"
     ),
    size = 3.5, family = "Noto Serif", fontface = "italic", color = "#a5a5a5") +
    labs(title = " Incarcerated Individuals in Paraguay")
  
map
