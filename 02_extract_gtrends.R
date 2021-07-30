# PROJECT: Using Google Trends to measure popularity of Czech political actors

# The resulting data should be treated with caution as to the
# interpretations of the popularity of given political actors.
# We should assume the existence of a sampling bias, as the Google search user-base
# will not likely be representative of the general Czech population.

# Ideally, this should be accompanied by other data sources, such as term
# searches on Seznam.cz, however, this platform do not easy programmatic access.

# PART 1: LOAD THE REQUIRED R LIBRARIES

# Package names
packages <- c("dplyr", "gtrendsR", "readr", "stringr", "tidyr")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages], repos = 'http://cran.rstudio.com', dependencies = TRUE)
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))


# PART 2: DEFINE THE FUNCTION THAT WILL EXTRACT AND SAVE GOOGLE TRENDS

extract_gtrends <- function(search_terms, start_date, end_date, dir_name) {

  # We have to create a desired directory, if one does not yet exist
  if (!dir.exists(dir_name)) {
    dir.create(dir_name)
  } else {
    print("Output directory already exists")
  }

  # We initialize empty dataset to which we add rows with each loop iteration
  gtrends_df <- tibble()

  # To get every item from the list, we need to use for loop
  for (i in seq_len(length(search_terms))) {

    # Formulate the Google Trends query using function from the gtrendsR package
    gtrends_query <- gtrends(
      keyword = search_terms[[i]],
      geo = "CZ",
      time = paste(start_date, end_date),
      gprop = "web",
      category = 0,
      hl = "cs",
      low_search_volume = FALSE,
      cookie_url = "http://trends.google.com/Cookies/NID",
      tz = 0,
      onlyInterest = FALSE
    )

    gtrends_query[[1]] <- gtrends_query[[1]] %>%
      transmute(
        date = date,
        entity_name = keyword,
        hits = as.integer(str_replace_all(hits, "<.*", "0")),
      ) %>%
      arrange(desc(date))

    gtrends_df <- bind_rows(gtrends_df, gtrends_query[[1]])
  }

  # Clean the downloaded dataset, select only appropriate columns
  clean_dataset <- gtrends_df %>%
    mutate(
      entity_name = as.factor(entity_name),
      entity_id = as.integer(entity_name)
    ) %>%
    arrange(desc(date))


  # We save the cleaned tables in a memory to a dedicated csv and rds file
  # Rds enables faster reading when using the dataset in R for further analyses
  # We turn off compression for rds files (optional). Their size is larger, but
  # the advantage are a magnitude faster read/write times using R.

  myfile_csv <- paste0(dir_name, "/full_data_gtrends.csv")
  myfile_rds <- paste0(dir_name, "/full_data_gtrends.rds")

  write_excel_csv(x = clean_dataset, file = myfile_csv)
  saveRDS(object = clean_dataset, file = myfile_rds, compress = FALSE)
}


## PART 3: SPECIFY INPUTS FOR THE WIKIPEDIA EXTRACTION FUNCTION
# The Wikipedia API goes back up to mid 2015
start_date <- as.Date("2015-07-01")

end_date <- Sys.Date()

search_terms <- readRDS("data/saved_search_terms_gtrends.rds")

# Specify output directory
dir_name <- "data"

# PART 4: RUNNING THE FUNCTION WITH APPROPRIATE ARGUMENTS
extract_gtrends(
  search_terms = search_terms,
  start_date = start_date,
  end_date = end_date,
  dir_name = dir_name
)
