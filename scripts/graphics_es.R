library(tidyverse)
library(ICplots)

source("~/Desktop/IC/2023/Argentina/Secuestros Extorsivos/scripts/finalize_plots.R")

prison_data$Prison <- as.factor(prison_data$Prison) %>%
  fct_reorder(prison_data$total)

bar_data <- prison_data %>%
  filter(!(is.na(convicted)) & convicted > 0) %>%
  pivot_longer(cols=c("pretrial", "convicted", "OfficialCapacity"),
               names_to = "detention_type", values_to = "population") 

# looking at official capacity instead of total population
prison_bar <- ggplot(subset(bar_data, !is.na(population) &
                               population > 0 & Prison != "Total")) +
  geom_col(aes(x = Prison, y = population, fill = detention_type),
           position = "dodge") +
  coord_flip() +
  scale_fill_manual(breaks = c("OfficialCapacity", "pretrial", "convicted"),
                    values = c("#4F7264", "#AFDDD4", "#BCB7AD"),
                    labels = c("Capacidad oficial", "Prisión preventiva", "Convictos")) +
  labs(title = "Desglose de la población carcelaria") +
  ylab("Número de presos") + 
  xlab("Nombre de la prisión") +
  theme_ic() +
  theme(axis.title.y = element_text(family = "Roboto", color = "#3B3B3B",
                                    size = 12, hjust = .5),
        axis.title.x = element_text(family = "Roboto", color = "#3B3B3B",
                                    size = 12, hjust = .5),
        axis.text.y = element_text(family = "Roboto", size = 12, color = "#3B3B3B"),
        axis.text.x = element_text(family = "Roboto", size = 12, color = "#3B3B3B"),
        legend.text = element_text(size = 12, color = "#3B3B3B"),
        plot.title = element_text(family = "Roboto Black"),
        panel.grid.major.y = ggplot2::element_line(
          linetype = 1,
          color = "#b3b3b3")) 

finalise_plot(plot_name = prison_bar,
              source = "Fuente: Ministerio de Justicia, mayo de 2023",
              save_filepath = "figs/bar_chart_es.png",
              height_pixels = 640,
              width_pixels = 640)

# Overpopulation
overpop_data <- prison_data %>%
  mutate(overpopulation = (total / OfficialCapacity * 100)) 
overpop_data$Prison <- as.factor(overpop_data$Prison) %>%
  fct_reorder(overpop_data$overpopulation)
#write_excel_csv(overpop_data, "data/overpop_data.csv")

overcap <- ggplot(subset(overpop_data, !is.na(overpopulation))) +
  geom_col(aes(x = Prison, y = overpopulation), fill = "#4F7264") +
  coord_flip() +
  labs(title = "Prisiones más sobrepobladas de Paraguay") + 
  ylab("Población real vs Capacidad oficial (%)") +
  xlab("Nombre de la prisión") +
  geom_hline(yintercept = 100, linetype = 2, color = "#3B3B3B") +
  geom_text(aes(x = 16.75, y = 105, label = "Exceso de capacidad", hjust = "left",
            family = "Roboto"), color = "#3B3B3B") + 
  geom_text(aes(x = 16.75, y = 95, label = "Por debajo de\nla capacidad", hjust = "right",
            family = "Roboto"), color = "#3B3B3B") +
  geom_text(aes(x = 17.4, y = 100, label = "")) + 
  theme_ic() +
  theme(axis.title.x = element_text(family = "Roboto", color = "#3B3B3B",
                                    size = 12),
        axis.title.y = element_text(family = "Roboto", color = "#3B3B3B",
                                    size = 12, hjust = .5),
        axis.text.y = element_text(family = "Roboto", size = 12, color = "#3B3B3B"),
        axis.text.x = element_text(family = "Roboto", size = 12, color = "#3B3B3B"),
        panel.grid.major.y = ggplot2::element_line(
          linetype = 1, color = "#b3b3b3"),
        plot.title = element_text(family = "Roboto Black")) +
  geom_segment(aes(x = 16, xend = 16, y = 95, yend = 0),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_segment(aes(x = 16, xend = 16, y = 105, yend = 200),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_segment(aes(x = 0, y = 0, xend = 15.5, yend = 0))
overcap

finalise_plot(plot_name = overcap,
              source = "Fuente: Ministerio de Justicia, mayo de 2023",
              save_filepath = "figs/overpop_es.png")
