########################
# Ryker Schwartzenberger
# Patrick Smith
# Laura Rickey
# Luke Baker
# INFO-498F
# Final Project
########################
# Run this file to update presidential poll data from Propublica API.
# candidate_data is the resultant dataframe, which is compiled data
# about the candidates specified in candidate_ids. Source this script
# in your code and use candidate_data.
########################
library(dplyr)
library(jsonlite)
library(httr)

options(stringsAsFactors = FALSE)

base_url <- 'https://api.propublica.org/campaign-finance/v1/'

# FEC ID's for some of the current candidates. Add to this list to begin
# collecting data on a new candidate.
candidate_ids <- c('P60007168',
                   'P00003392',
                   'P80001571',
                   'P60006111')

campaign_cycles <- c('2016')

# Come up with a better means to create this list....
state_path <- c('/candidates/P60007168.json',
                '/candidates/P00003392.json',
                '/candidates/P80001571.json',
                '/candidates/P60006111.json')

# Takes an FEC ID in, polls Propublica API for current data and writes 
# to a .csv file in the data/ directory.
queryCandidateData <- function(id) {
  
  query <- paste0(base_url, '2016/candidates/', id, '.json')
  response <- GET(query, add_headers('X-API-Key' = '6PV7DzVbl5ji6l3hAYPh3ElWARo5E9I78KMvfTJi'))
  data <- as.data.frame(fromJSON(content(response, type='text', encoding = 'UTF-8'))) %>% 
          flatten()
  df <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  file_addr <- paste0('../data/', id, '.csv')
  write.csv(df, file_addr)
  
}

# Queries the Propublica campaign finance API for an even numbered
# year campaign_cycle and writes to a .csv file in data/
queryCampaignData <- function(campaign_cycle) {
  
  query <- paste0(base_url, campaign_cycle, '/president/totals.json')
  response <- GET(query, add_headers('X-API-Key' = '6PV7DzVbl5ji6l3hAYPh3ElWARo5E9I78KMvfTJi'))
  data <- as.data.frame(fromJSON(content(response, type='text', encoding = 'UTF-8'))) %>% 
    flatten()
  df <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  file_addr <- paste0('../data/', 'totals_', campaign_cycle, '.csv')
  write.csv(df, file_addr)
  
}

# Queries data from the Propublica campaign finance API for results
# based on state and saves it to a .csv file in the data/ directory.
queryStateData <- function(campaign_cycle, state) {
  
  query <- paste0(base_url, campaign_cycle, '/president/states/', state, '.json')
  response <- GET(query, add_headers('X-API-Key' = '6PV7DzVbl5ji6l3hAYPh3ElWARo5E9I78KMvfTJi'))
  data <- as.data.frame(fromJSON(content(response, type='text', encoding = 'UTF-8'))) %>% 
    flatten()
  df <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  file_addr <- paste0('../data/', state, '_', campaign_cycle, '.csv')
  write.csv(df, file_addr)
  
}

# Don't use this funciton, use getCampaignData instead. 
getCandidateData <- function(candidate_list) {
  
  file_addr <- paste0('../data/', candidate_list[1], '.csv')
  candidate_data <- read.csv(file_addr)
  
  for (i in 2:length(candidate_list)) {
    file_addr <- paste0('../data/', candidate_list[i], '.csv')
    temp_frame <- read.csv(file_addr)
    candidate_data <- rbind(candidate_data, temp_frame)
  }
  
  return(candidate_data)
}

# Returns a data frame from campaign_cylce, queried on data (in Sys.Date() form),
# containing data about the presidential candidates in cand_ids.
getCampaignData <- function(campaign_cycle, cand_ids) {
 
  file_addr <- paste0('../data/', 'totals_', campaign_cycle, '.csv')
  
  campaign_data <- read.csv(file_addr) %>% 
    subset(results.candidate_id %in% cand_ids)
  
  return(campaign_data)
}

# Returns a data frame with information on canidates in candidate_ids
# for state.
getStateData <- function(campaign_cycle, state) {
  
  file_addr <- paste0('../data/', state, '_', campaign_cycle, '-', '.csv')
  
  state_data <- read.csv(file_addr) %>% 
    subset(results.candidate %in% state_path)
  
  return(state_data)
}
