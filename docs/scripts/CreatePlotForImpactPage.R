### TITLE ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

loaddata <- read_csv("static/files/downloads_vs_impact.csv")

set.seed(2020)
loaddata %>%
  group_by(journal) %>%
  summarise(median_downloads = median(downloads, na.rm = TRUE),
            n_articles = n(),
            impact_factor = first(impact)) %>%
  mutate(journal = str_to_title(journal)) %>%
  ggplot(aes(x = median_downloads, y = impact_factor)) + 
  geom_point(aes(size = n_articles), alpha = 0.8, color = "white") +
  geom_smooth(method = "lm", color = "mediumpurple") +
  ggrepel::geom_text_repel(aes(label = journal), size = 3, color = "white") +
  labs(x = expression(paste("Median number of downloads (",log[10],"-transformed)")),
       y = expression(paste("Journal impact factor (",log[10],"-transformed)")),
       size = "Number of articles") +
  scale_x_log10(limits = c(NA,3000)) +
  scale_y_log10(limits = c(NA,40)) +
  normentR::theme_norment(dark = TRUE, bg_col = "transparent") +
  theme(rect = element_rect(fill = "transparent", color = "transparent"),
        panel.background = element_rect(color = "transparent"),
        plot.background = element_rect(color = "transparent"))

set.seed(2020)
ggsave("static/images/median_downloads_vs_impact.png", width = 8, height = 6, units = "in", 
       bg = "transparent")
