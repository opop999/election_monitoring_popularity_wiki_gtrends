# Package names
packages <- c("dplyr", "tidyr", "data.table")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))

# Datasets loading
full_wiki_table <- readRDS("data/full_data_wiki.rds")
full_gtrends_table <- readRDS("data/full_data_gtrends.rds")

# Check whether output directory exists
if (!dir.exists("data/summary_tables")) {
  dir.create("data/summary_tables")
} else {
  print("Output directory already exists")
}

# Create a summary table of total and per year hits of Wikipedia and Google search
summary_table_total_wiki <- full_wiki_table %>%
  group_by(entity_name, entity_id) %>%
  summarise(total_views = sum(views)) %>%
  arrange(desc(total_views)) %>%
  ungroup()

summary_table_total_gtrends <- full_gtrends_table %>%
  group_by(entity_name, entity_id) %>%
  summarise(total_hits = sum(hits)) %>%
  arrange(desc(total_hits)) %>%
  ungroup()

summary_table_per_year_wiki <- full_wiki_table %>%
  mutate(year = format(date, format = "%Y")) %>%
  group_by(year, entity_name, entity_id) %>%
  summarise(total_views = sum(views)) %>%
  arrange(desc(year), desc(total_views)) %>%
  ungroup()

summary_table_per_year_gtrend <- full_gtrends_table %>%
  mutate(year = format(date, format = "%Y")) %>%
  group_by(year, entity_name, entity_id) %>%
  summarise(total_hits = sum(hits)) %>%
  arrange(desc(year), desc(total_hits)) %>%
  ungroup()

# Saving Wikipedia summaries
fwrite(summary_table_total_wiki, "data/summary_tables/total_views_summary_wiki.csv")
saveRDS(object = summary_table_total_wiki, file = "data/summary_tables/total_views_summary_wiki.rds", compress = FALSE)

fwrite(summary_table_per_year_wiki, "data/summary_tables/per_year_views_summary_wiki.csv")
saveRDS(object = summary_table_per_year_wiki, file = "data/summary_tables/per_year_views_summary_wiki.rds", compress = FALSE)

# Saving Gtrend summaries
fwrite(summary_table_total_gtrends, "data/summary_tables/total_views_summary_gtrends.csv")
saveRDS(object = summary_table_total_gtrends, file = "data/summary_tables/total_views_summary_gtrends.rds", compress = FALSE)

fwrite(summary_table_per_year_gtrend, "data/summary_tables/per_year_views_summary_gtrends.csv")
saveRDS(object = summary_table_per_year_gtrend, file = "data/summary_tables/per_year_views_summary_gtrends.rds", compress = FALSE)
