### GENERATE CLUE ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

name <- "Communications" %>%
  strsplit(., "") %>%
  .[[1]]

set.seed(2020)
name[sample(seq(length(name)))]

