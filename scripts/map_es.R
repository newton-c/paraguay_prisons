library(tidyverse)

map_df <- map_data("world") %>% 
  select(lon = long, lat, group, region, id = subregion)

data_labels <-  tibble(x = c(-60, -50, -62, -65),
                      y = c(-22, -24.5, -28, -21),
                      label = c("Paraguay", "Brasil", "Argentina", "Bolivia"))

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
        plot.caption = ggplot2::element_blank(),
        plot.margin = margin(6, 6, 6, 6)) + 
  coord_sf(xlim = c(-66.5, -49.25), ylim = c(-29, -19)) +
  geom_point(subset(prison_data, !(Prison %in% c("Tacumbú", "San Pedro", "Misiones"))),
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = subset(prison_data, !(Prison %in% c("Tacumbú", "San Pedro", "Misiones")))$OfficialCapacity / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#AFDDD4",
             stroke = .5,
             alpha = .3) +
  geom_point(subset(prison_data, !(Prison %in% c("Tacumbú", "San Pedro", "Misiones"))),
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = subset(prison_data, !(Prison %in% c("Tacumbú", "San Pedro", "Misiones")))$total / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#4F7264",
             stroke = .5,
             alpha = .3) +
  geom_point(aes(x = c(-66.8), y = c(-19, -19.6)), size = 4, alpha = .7, 
             shape = 21, fill = c("#4F7264", "#AFDDD4")) +
  geom_point(subset(prison_data, Prison %in% c("Tacumbú", "San Pedro", "Misiones")),
             mapping = aes(x = lon, y = lat,
                                      fill = total),
             size = subset(prison_data, Prison %in% c("Tacumbú", "San Pedro", "Misiones"))$total / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#4F7264",
             stroke = 1,
             alpha = .8) +
  geom_point(subset(prison_data, Prison %in% c("Tacumbú", "San Pedro", "Misiones")),
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = subset(prison_data, Prison %in% c("Tacumbú", "San Pedro", "Misiones"))$OfficialCapacity / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#AFDDD4",
             stroke = 1,
             alpha = .8) +

  geom_text(mapping = aes(x = c(-66.5), y = c(-19, -19.6),
                          label = c("Población real",
                                    "Capacidad oficial")),
            hjust = "left",
            family = "Roboto") +
  geom_segment(mapping = aes(x = -65, y = -25.30843,
                             xend = -58.8, yend = -25.30842),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_label(mapping = aes(x = -66.355, y = -26,
                           label = paste("Tacumbú tiene 2.847",
                                         "presos, más de la",
                                         "mitad de los cuales no",
                                         "han tenido un juicio.",
                                         "La capacidad oficial es",
                                         "de 1.530 personas.",
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
  geom_label(mapping = aes(x = -54.75, y = -27,
                           label = paste("En la cárcel de Misiones,",
                                         "solo 411 de los 1.412",
                                         "presos están condenados.",
                                         "En 2022, 35 presos",
                                         "secuestraron a un guardia y",
                                         "escaparon. La capacidad",
                                         "oficial es de 920 personas.",
                                         sep = "\n")),
             family = "Roboto",
             size = 4,
             color = "#3B3B3B",
             hjust = "left",
             label.r = unit(0, "lines"),
             label.padding = unit(0.5, "lines"),
             lineheight = .9) +
  geom_segment(mapping = aes(x = -53, y = -21,
                             xend = -56.75, yend = -24),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_label(mapping = aes(x = -56, y = -20.9,
                           label = paste("En San Pedro se presentó",
                                         "una conocida masacre cuando",
                                         "miembros del PCC asesinaron",
                                         "a 10 miembros del Clan Rotela",
                                         "en 2019. La prisión tiene",
                                         "capacidad para 696 personas,",
                                         "pero alberga una población de",
                                         "1.145 presos.",
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
  geom_text(mapping = aes(x = -63, y = -29.2, label = "Fuente: Ministerio de Justicia, mayo de 2023"
  ),
  size = 3.5, family = "Roboto", color = "#a5a5a5") +
    labs(title = "  Las sobrepobladas cárceles de Paraguay\n  han favorecido el crimen organizado")
  
map

# mapa sin cajas de texto para el newletter
map_es_nl <- ggplot() +
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
    plot.caption = ggplot2::element_blank(),
    plot.margin = margin(6, 6, 6, 6)) + 
  coord_sf(xlim = c(-66.5, -49.25), ylim = c(-29, -19)) +
  geom_point(prison_data,
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = prison_data$total / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#4F7264",
             stroke = 1,
             alpha = .8) +
  geom_point(prison_data,
             mapping = aes(x = lon, y = lat,
                           fill = total),
             size = prison_data$OfficialCapacity / 100,
             shape = 21,
             color = "#3B3B3B",
             fill = "#AFDDD4",
             stroke = 1,
             alpha = .8) +
  geom_point(aes(x = c(-66.8), y = c(-19, -19.6)), size = 4, alpha = .7, 
             shape = 21, fill = c("#4F7264", "#AFDDD4")) +
  geom_text(mapping = aes(x = -66.5, y = -19,
                          label = "Población carcelaria real",
                          vjust = .5),
            hjust = "left",
            family = "Roboto") +
  geom_text(mapping = aes(x = -66.5, y = -19.6,
                          label = "Capacidad carcelaria\noficial",
                          vjust = .8),
            hjust = "left",
            family = "Roboto") +
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
  geom_text(mapping = aes(x = -63, y = -29.2, label = "Fuente: Ministerio de Justicia, mayo de 2023"
  ),
  size = 3.5, family = "Roboto", color = "#a5a5a5") 

map_es_nl
