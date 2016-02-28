########################
# Ryker Schwartzenberger
# Patrick Smith
# Laura Rickey
# Luke Baker
# INFO-498F
# Final Project
########################
# Run this file to update presidential poll data from Propublica API.

library(jsonlite)
library(httr)

options(stringsAsFactors = FALSE)

base_url <- 'https://api.propublica.org/campaign-finance/v1/'
cycle <- "2016"

# FEC ID's for some of the current candidates. Add to this list to begin
# collecting data on a new candidate.
candidate_ids <- c("P60007168",
                   "P00003392",
                   "P80001571",
                   "P60006111")

# Takes an FEC ID in, polls Propublica API for current data and writes 
# to a .csv file in the data/ directory.
getCandidateData <- function(id) {
  
  query <- paste0(base_url, cycle, '/', 'candidates', '/', id, ".json")
  response <- GET(query, add_headers("X-API-Key" = "6PV7DzVbl5ji6l3hAYPh3ElWARo5E9I78KMvfTJi"))
  data <- as.data.frame(fromJSON(content(response, type='text', encoding = 'UTF-8')))
  df <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  file_addr <- paste0('../data/', Sys.Date(), '_', id, '.csv')
  write.csv(df, file_addr)
  
}

lapply(candidate_ids, getCandidateData)

