library(dplyr)
library(readr)
library(tidyr)

full_wiki_table <- readRDS("data/full_data.rds")

if (!dir.exists("data/summary_tables")) {
  dir.create("data/summary_tables")
} else {
  print("output directory already exists")
}

# Creating a summary table focused on the detailed aspects of the advertising
# Percentage figures rounded to 3 decimal places
summary_table_total <- full_wiki_table %>%
  group_by(entity_name, entity_id) %>%
  summarise(total_views = sum(views)) %>%
  arrange(desc(total_views))

summary_table_per_year <- full_wiki_table %>%
  mutate(year = format(date, format = "%Y")) %>%
  group_by(year, entity_name, entity_id) %>%
  summarise(total_views = sum(views)) %>%
  arrange(desc(year), desc(total_views))



write_csv(summary_table_total, "data/summary_tables/total_views_summary.csv")
saveRDS(object = summary_table_per_year, file = "data/summary_tables/total_views_summary.rds", compress = FALSE)

write_csv(summary_wiki_table, "data/summary_tables/per_year_views_summary.csv")
saveRDS(object = summary_table_per_year, file = "data/summary_tables/per_year_views_summary.rds", compress = FALSE)
