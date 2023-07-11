library(tidyverse)
library(readxl)
library(jsonlite)

file_path <- "data/12669-DATOSESTASDISTICOS2023xlsx-DATOSESTASDISTICOS2023.xlsx"
col_names <- c("N", "prison", "pretrial", "convicted", "total", "6", "7", "8",
               "9", "10", "11", "12", "13", "14", "15")

prison_pop <- read_xlsx(file_path, skip = 3, na = "X",
                        col_names = col_names) %>%
  select(col_names[1:5]) %>%
  mutate(prison = ifelse(is.na(prison), "TOTAL", prison),
         N = as.numeric(ifelse(N == "TOTAL", "19", N))) %>%
  filter(!is.na(N))
rm(list = c("file_path", "col_names"))

capacidad <- read_xlsx("data/capacity2022.xlsx")

prison_data <- full_join(prison_pop, capacidad) %>%
  select(-prison) %>%
  mutate(pretrial = as.numeric(pretrial),
         convicted = as.numeric(convicted))

rm(list = c("capacidad", "prison_pop"))

toJSON(prison_data)
write_excel_csv(prison_data, "data/prison_data.csv")

# 2022, monthly crimes
delitos22 <- read_xlsx("data/delitos2022.xlsx")

hurtos <- delitos22 %>%
  group_by(mes) %>%
  filter(Crime == "HURTO" | Crime == "HURTO AGRAVADO") %>%
  summarise(hurtos = sum(DENUNCIADOS))

robos <- delitos22 %>%
  group_by(mes) %>%
  filter(grepl("ROBO", Crime)) %>%
  summarise(robos = sum(DENUNCIADOS))

robos_y_hurtos <- full_join(robos, hurtos) %>%
  mutate(robos_y_hurtos = robos + hurtos)
