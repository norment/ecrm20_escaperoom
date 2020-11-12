### PYTHON SCRIPT TO GET THE CLUE FOR THE NEXT TASK ########################

#-- Libraries -------------------------

import pandas as pd
import numpy as np

#-- Load data ------------------------

loaddata = pd.read_csv("downloads_vs_impact.csv")

#-- Calculate median number of downloads per journal ------------------------

median_downloads = loaddata.groupby('journal')[['downloads']].median()

data = pd.merge(median_downloads,loaddata)
data = data[['journal','downloads','impact']]
data.sort_values('downloads', ascending=False)
