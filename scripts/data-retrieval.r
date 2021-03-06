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

## Add your API key below
api_key <- ''

# FEC ID's for some of the current candidates. Add to this list to begin
# collecting data on a new candidate.
candidate_ids <- c('P60007168',
                   'P00003392',
                   'P80001571',
                   'P60006111')

# Presidential election years that are currently supported by the API.
campaign_cycles <- c('2000', '2004', '2008', '2012')

# List of the presidential nominees (democratic and republican)
# for each campaign cycle from 2000-present.
id_per_cycle <- list(
  ids_2000 <- list('P00003335', 'P80000912'),
  ids_2004 <- list('P00003335', 'P80000235'),
  ids_2008 <- list('P80003338', 'P80002801'),
  ids_2012 <- list('P80003338', 'P80003353')
)

state_path <- c('/candidates/P60007168.json',
                '/candidates/P00003392.json',
                '/candidates/P80001571.json',
                '/candidates/P60006111.json')

# Takes an FEC ID in, polls Propublica API for current data and writes 
# to a .csv file in the data/ directory.
queryCandidateData <- function(id, campaign_cycle) {
  
  query <- paste0(base_url, campaign_cycle, '/candidates/', id, '.json')
  response <- GET(query, add_headers('X-API-Key' = api_key))
  data <- as.data.frame(fromJSON(content(response, type='text', encoding = 'UTF-8'))) %>% 
          flatten()
  df <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  file_addr <- paste0('data/', id, '_', campaign_cycle, '.csv')
  write.csv(df, file_addr)
  
}

# Queries the Propublica campaign finance API for an even numbered
# year campaign_cycle and writes to a .csv file in data/
queryCampaignData <- function(campaign_cycle) {
  
  query <- paste0(base_url, campaign_cycle, '/president/totals.json')
  response <- GET(query, add_headers('X-API-Key' = api_key))
  data <- as.data.frame(fromJSON(content(response, type='text', encoding = 'UTF-8'))) %>% 
    flatten()
  df <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  file_addr <- paste0('data/', 'totals_', campaign_cycle, '.csv')
  write.csv(df, file_addr)
  
}

# Queries data from the Propublica campaign finance API for results
# based on state and saves it to a .csv file in the data/ directory.
queryStateData <- function(campaign_cycle, state) {
  
  query <- paste0(base_url, campaign_cycle, '/president/states/', state, '.json')
  response <- GET(query, add_headers('X-API-Key' = api_key))
  data <- as.data.frame(fromJSON(content(response, type='text', encoding = 'UTF-8'))) %>% 
    flatten()
  df <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  file_addr <- paste0('data/', state, '_', campaign_cycle, '.csv')
  write.csv(df, file_addr)
  
}

# Returns a data frame containing data about candidates in candidate_list
# from campaign_cycle.
getCandidateData <- function(candidate_list, campaign_cycle) {
  
  file_addr <- paste0('data/', candidate_list[1], '_', campaign_cycle, '.csv')
  candidate_data <- read.csv(file_addr)
  
  if (length(candidate_list) > 1) {
    for (i in 2:length(candidate_list)) {
      file_addr <- paste0('data/', candidate_list[i], '_', campaign_cycle, '.csv')
      temp_frame <- read.csv(file_addr)
      candidate_data <- rbind(candidate_data, temp_frame)
    }
  }
  
  return(candidate_data)
}

# Returns a data frame from campaign_cylce, queried on data (in Sys.Date() form),
# containing data about the presidential candidates in cand_ids.
aggCampaignData <- function(campaign_cycle, candidate_list) {
  
  file_addr <- paste0('data/', 'totals_', campaign_cycle, '.csv')
  campaign_data <- read.csv(file_addr) %>% 
    subset(results.candidate_id %in% candidate_list)
  
  return(campaign_data)
}

# Aggregates data from all 50 states for even numbered year campaign_cycle 
# and returns it as a dataframe. 
aggStateData <- function(campaign_cycle) {
  
  agg_data <- getStateData(campaign_cycle, state.abb[1])
  for (i in 2:length(state.abb)) {
    temp_frame <- getStateData(campaign_cycle, state.abb[i])
    agg_data <- rbind(agg_data, temp_frame)
  }
  
  return(agg_data)
}

# Returns a data frame with information on canidates in candidate_ids
# for state_abb. state_abb must be an all-uppercase two letter state code.
getStateData <- function(campaign_cycle, state_abb) {
  
  file_addr <- paste0('data/', state_abb, '_', campaign_cycle, '.csv')
  state_data <- read.csv(file_addr) %>% 
    subset(results.candidate %in% state_path)
  
  return(state_data)
}
