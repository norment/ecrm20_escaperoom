### SCRIPT TO GET THE CLUE FOR THE NEXT TASK ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

loaddata <- read_csv("downloads_vs_impact.csv")

#-- Calculate median number of downloads per journal ------------------------

median_downloads_per_journal <- loaddata %>%
  group_by(journal) %>%
  summarise(median_downloads = median(downloads, na.rm = TRUE),
            impact_factor = first(impact)) %>%
  arrange(-median_downloads)

print(median_downloads_per_journal)


#-- BONUS: Plot the relationship between impact factor and median number of downloads ------------------------

median_downloads_per_journal <- loaddata %>%
  group_by(journal) %>%
  summarise(median_downloads = median(downloads, na.rm = TRUE),
            n_articles = n(),
            impact_factor = first(impact))

ggplot(median_downloads_per_journal, aes(x = median_downloads, y = impact_factor)) + 
  geom_point(aes(size = n_articles), alpha = 0.8) +
  geom_smooth(method = "lm") +
  ggrepel::geom_text_repel(aes(label = journal)) +
  theme_minimal()

