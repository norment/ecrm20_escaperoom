### GENERATE CSV FILE ########################

#-- Libraries -------------------------

library(tidyverse)
library(here)

#-- Load data ------------------------

data1 <- read_csv("/Users/dtroelfs/Downloads/impact_scores.csv")
data2 <- read_csv("/Users/dtroelfs/Downloads/downloads_journal.csv")

#-- Prepare data ------------------------

data <- data1 %>%
  mutate(journal = str_to_lower(journal)) %>%
  left_join(data2, by = "journal")

#-- Recreate plot ------------------------

plotdata <- data %>%
  group_by(journal) %>%
  summarise(median = median(downloads, na.rm = TRUE),
            n = n(),
            impactfactor = first(impact)) %>%
  drop_na() %>%
  mutate(journal = str_to_title(journal))

ggplot(plotdata, aes(x = median, y = impactfactor)) +
  geom_point(aes(size = n), alpha = 0.8) + 
  geom_smooth(method = "lm", se = FALSE) +
  ggrepel::geom_text_repel(aes(label = journal)) +
  #scale_x_continuous(limits = c(0,3000), breaks = seq(0,3000,1000)) +
  scale_x_continuous(trans = "log2", breaks = seq(0,3000,1000), limits = c(NA,3000)) +
  scale_y_continuous(trans = "log2") +
  theme_minimal()

#-- Write data ------------------------

write_csv(data, here("static","files","downloads_vs_impact.csv"))
