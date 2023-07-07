library(tidyverse)
library(ICplots)

source("~/Desktop/IC/2023/Argentina/Secuestros Extorsivos/scripts/finalize_plots.R")

prison_data$Prison <- as.factor(prison_data$Prison) %>%
  fct_reorder(prison_data$total)

bar_data <- prison_data %>%
  filter(!(is.na(convicted)) & convicted > 0) %>%
  #pivot_longer(cols=c("pretrial", "convicted", "total"),
  pivot_longer(cols=c("pretrial", "convicted", "OfficialCapacity"),
               names_to = "detention_type", values_to = "population") 

prison_bar <-
  ggplot(subset(bar_data, !is.na(population) & population > 0 & Prison != "Total")) +
  geom_col(aes(x = Prison, y = population, fill = detention_type),
           position = "dodge") +
  coord_flip() +
  scale_fill_manual(breaks = c("total", "pretrial", "convicted"),
                    values = c("#3B3B3B", "#A7213B", "#E5AD32"),
                    labels = c("Total", "Pretrial", "Convicted")) +
  labs(title = "Incarcerated Individuals in Paraguay",
       subtitle = "May 2023") +
  theme_ic()

finalise_plot(plot_name = prison_bar,
              source = "Sources: Ministry of Justice",
              save_filepath = "figs/bar_chart_en.png")

ggplotly(prison_bar)

# looking at official capacity instead of total population
prison_bar2 <-
  ggplot(subset(bar_data, !is.na(population) & population > 0 & Prison != "Total")) +
  geom_col(aes(x = Prison, y = population, fill = detention_type),
           position = "dodge") +
  coord_flip() +
  scale_fill_manual(breaks = c("OfficialCapacity", "pretrial", "convicted"),
                    values = c("#4F7264", "#AFDDD4", "#BCB7AD"),
                    labels = c("Official Capacity", "Pretrial", "Convicted")) +
  labs(title = "Incarcerated Individuals in Paraguay") +
  theme_ic() +
  theme(axis.title.x = element_text(family = "Roboto", color = "#3B3B3B",
                                    size = 12),
        axis.text.y = element_text(size = 12, color = "#3B3B3B"),
        axis.text.x = element_text(size = 12, color = "#3B3B3B"),
        legend.text = element_text(size = 12, color = "#3B3B3B")) 

finalise_plot(plot_name = prison_bar2,
              source = "Source: Ministry of Justice, May 2023",
              save_filepath = "figs/bar_chart2_en.png",
              height_pixels = 640,
              width_pixels = 640)

ggplotly(prison_bar2)

# Overpopulation
overpop_data <- prison_data %>%
  mutate(overpopulation = (total / OfficialCapacity * 100)) 
overpop_data$Prison <- as.factor(overpop_data$Prison) %>%
  fct_reorder(overpop_data$overpopulation)
#write_excel_csv(overpop_data, "data/overpop_data.csv")

overcap <- ggplot(subset(overpop_data, !is.na(overpopulation))) +
  geom_col(aes(x = Prison, y = overpopulation), fill = "#4F7264") +
  coord_flip() +
  labs(title = "Most Overpopulated Prisons in Paraguay") + 
  ylab("Actual Population vs Official Capaciaty (%)") +
  geom_hline(yintercept = 100, linetype = 2, color = "#3B3B3B") +
  geom_text(aes(x = 16.75, y = 105, label = "overcapacity", hjust = "left",
            family = "Roboto"), color = "#3B3B3B") + 
  geom_text(aes(x = 16.75, y = 95, label = "undercapacity", hjust = "right",
            family = "Roboto"), color = "#3B3B3B") +
  geom_text(aes(x = 17.4, y = 100, label = "")) + 
  theme(axis.title.x = element_text(family = "Roboto", color = "#3B3B3B",
                                    size = 12),
        axis.text.y = element_text(size = 12, color = "#3B3B3B"),
        axis.text.x = element_text(size = 12, color = "#3B3B3B")) +
  geom_segment(aes(x = 16, xend = 16, y = 95, yend = 0),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_segment(aes(x = 16, xend = 16, y = 105, yend = 200),
               arrow = arrow(length = unit(0.25, "cm"))) +
  geom_segment(aes(x = 0, y = 0, xend = 15.5, yend = 0)) +
  theme_ic() 
overcap

finalise_plot(plot_name = overcap,
              source = "Source: Ministry of Justice, May 2023",
              save_filepath = "figs/overpop_en.png")
