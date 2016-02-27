########################
# Ryker Schwartzenberger
# Patrick Smith
# Laura Rickey
# Luke Baker
# INFO-498F
# Final Project
########################

library(jsonlite)
library(dplyr)
library(httr)

options(stringsAsFactors = FALSE)

base_url <- 'https://api.propublica.org/campaign-finance/v1/'
cycle <- "2016"
candidate_id <- "S4VT00033"

query <- paste0(base_url, '/', cycle, '/', 'candidates', '/', candidate_id)
response <- GET(query, add_headers("x-api-key"= " 6PV7DzVbl5ji6l3hAYPh3ElWARo5E9I78KMvfTJi"))
data <- fromJSON(content(response, type='text', encoding = 'UTF-8'))
