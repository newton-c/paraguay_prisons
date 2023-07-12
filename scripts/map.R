library(tidyverse)

map_df <- map_data("world") %>% 
  select(lon = long, lat, group, region, id = subregion)

data_labels <-  tibble(x = c(-60, -50, -62, -65),
                      y = c(-22, -25, -29, -20),
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
  geom_point(subset(prison_data, !(Prison %in% c("Nacional", "San Pedro", "Misiones"))),
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = subset(prison_data, !(Prison %in% c("Nacional", "San Pedro", "Misiones")))$OfficialCapacity / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#AFDDD4",
             stroke = .5,
             alpha = .3) +
  geom_point(subset(prison_data, !(Prison %in% c("Nacional", "San Pedro", "Misiones"))),
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = subset(prison_data, !(Prison %in% c("Nacional", "San Pedro", "Misiones")))$total / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#4F7264",
             stroke = .5,
             alpha = .3) +
  geom_point(aes(x = c(-67.3, -63), y = -19), size = 4, alpha = .7, 
             shape = 21, fill = c("#4F7264", "#AFDDD4")) +
  geom_point(subset(prison_data, Prison %in% c("Nacional", "San Pedro", "Misiones")),
             mapping = aes(x = lon, y = lat,
                                      fill = total),
             size = subset(prison_data, Prison %in% c("Nacional", "San Pedro", "Misiones"))$total / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#4F7264",
             stroke = 1,
             alpha = .8) +
  geom_point(subset(prison_data, Prison %in% c("Nacional", "San Pedro", "Misiones")),
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = subset(prison_data, Prison %in% c("Nacional", "San Pedro", "Misiones"))$OfficialCapacity / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#AFDDD4",
             stroke = 1,
             alpha = .8) +

  geom_text(mapping = aes(x = c(-67, -62.7), y = -19,
                          label = c("Actual Population",
                                    "Official Capacity")),
            hjust = "left",
            family = "Roboto") +
  geom_segment(mapping = aes(x = -65, y = -25.30843,
                             xend = -58.8, yend = -25.30842),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_label(mapping = aes(x = -66.355, y = -26,
                           label = paste("Tacumbú has 2,847",
                                         "prisoners, more than",
                                         "half of which haven't",
                                         "had a trial. The",
                                         "official capacity is 1,530.",
                                         sep = "\n")),
             family = "Roboto",
             size = 4,
             color = "#3B3B3B",
             hjust = "left",
             label.r = unit(0, "lines"),
             label.padding = unit(0.5, "lines"),
             lineheight = .9) +
  geom_segment(mapping = aes(x = -53, y = -26.7,
                             xend = -56.45, yend = -26.7),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_label(mapping = aes(x = -54.6, y = -27.45,
                           label = paste("In Misiones prison,",
                                         "only 411 of the 1412",
                                         "are sentenced. In 2022",
                                         "35 prisoners kidnapped a",
                                         "guard and escaped. The",
                                         "official capacity is 920.",
                                         sep = "\n")),
             family = "Roboto",
             size = 4,
             color = "#3B3B3B",
             hjust = "left",
             label.r = unit(0, "lines"),
             label.padding = unit(0.5, "lines"),
             lineheight = .9) +
  geom_segment(mapping = aes(x = -53, y = -21,
                             xend = -56.75, yend = -23.7),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_label(mapping = aes(x = -56, y = -20.4,
                           label = paste("San Pedro was the site,",
                                         "of an infamous massacre",
                                         "when members of the PCC",
                                         "murdered 10 members of the",
                                         "Rotal Clan in 2019. The",
                                         "prison can hold 696 people.",
                                         "Its population is 1,145.",
                                         sep = "\n")),
             family = "Roboto",
             size = 4,
             color = "#3B3B3B",
             hjust = "left",
             label.r = unit(0, "lines"),
             label.padding = unit(0.5, "lines"),
             lineheight = .9) +
  geom_text(data_labels,
            mapping = aes(x = x,
                          y = y,
                          label = label),
            family = "Roboto Bold", size = 4,
            color = ifelse(data_labels$label == "Paraguay",
                           "#3B3B3B", "#B3B3B3")) +
  geom_text(mapping = aes(x = -51.5, y = -29.2, label = 
    "i\u200An\u200As\u200Ai\u200Ag\u200Ah\u200At\u200Ac\u200Ar\u200Ai\u200Am\u200Ae\u200A.\u200Ao\u200Ar\u200Ag"
     ),
    size = 3.5, family = "Noto Serif", fontface = "italic", color = "#a5a5a5") +
    labs(title = " Incarcerated Individuals in Paraguay")
  
map
