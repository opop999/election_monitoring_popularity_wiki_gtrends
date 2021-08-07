[![Extraction of Wiki & Gtrends statistics with Docker Image](https://github.com/opop999/election_monitoring_popularity_wiki_gtrends/actions/workflows/docker.yml/badge.svg)](https://github.com/opop999/election_monitoring_popularity_wiki_gtrends/actions/workflows/docker.yml)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

# This repository is part of a [umbrella project](https://github.com/opop999?tab=projects) of the [2021 pre-election monitoring](https://www.transparentnivolby.cz/snemovna2021/) by the Czech chapter of Transparency International.

## Goal: Extraction & analysis of the popularity metrics of political entities using Google Trends and Wikipedia page readership data

### Data: 
- Google Trends: Obtained through gtrendsR R package, which provides interface to the information regarding Google searches and their relative popularity (0-100)
- Wikipedia: Through pageviews R package, which accesses the MediaWiki API, gathering information about the number of visits to individual Wiki pages


### Target searched entities (work in progress):

| **POLITICAL SUBJECT**                 | 
| :---                                  | 
| ANO 2011                              |
| Česká strana sociálně demokratická    |
| Starostové a nezávislí                |
| TOP 09                                |
| Česká pirátská strana                 |
| Svoboda a přímá demokracie            |
| Trikolora Svobodní Soukromníci        |
| Trikolóra hnutí občanů                |
| Komunistická strana Čech a Moravy     |
| Strana zelených                       |
| Přísaha                               |
| KDU-ČSL                               |
| Občanská demokratická strana          |                          
