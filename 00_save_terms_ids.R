# To improve readability of the main script and its length, this script is made
# to be modified. We can add and remove the monitored Wikipedia pages and then
# we save the list to a rds file, which is read to the main extraction script.

article_ids_wiki <- c(
  "ANO_2011",
  "Česká_strana_sociálně_demokratická",
  "Starostové_a_nezávislí",
  "TOP_09",
  "Česká_pirátská_strana",
  "Svoboda_a_přímá_demokracie",
  "Trikolora_Svobodní_Soukromníci",
  "Trikolóra_hnutí_občanů",
  "Komunistická_strana_Čech_a_Moravy",
  "Strana_zelených",
  "Přísaha_-_občanské_hnutí_Roberta_Šlachty",
  "KDU-ČSL",
  "Občanská_demokratická_strana"
)


saveRDS(article_ids_wiki, "saved_article_ids_wiki.rds", compress = FALSE)

gtrends_search_terms <- list(
  c(
    "ANO 2011",
    "Česká strana sociálně demokratická",
    "Starostové a nezávislí",
    "TOP 09",
    "Česká pirátská strana"
  ),
  c(
    "Svoboda a přímá demokracie",
    "Trikolora Svobodní Soukromníci",
    "Komunistická strana Čech a Moravy",
    "Strana zelených",
    "Robert Šlachta"
  ),
  c(
    "KDU-ČSL",
    "Občanská demokratická strana"
  )
)

saveRDS(gtrends_search_terms, "saved_search_terms_gtrends.rds", compress = FALSE)
