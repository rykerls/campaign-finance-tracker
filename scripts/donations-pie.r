########################
# Ryker Schwartzenberger
# Patrick Smith
# Laura Rickey
# Luke Baker
# INFO-498F
# Final Project
########################
#This script returns a piechart showing the breakdown of where a candidate recieved their donations
#by donation level

#Loading data retrieval scripts, loading required packages, and setting global options. 
source("scripts/data-retrieval.r") 
options(stringsAsFactors = FALSE)
library(dplyr)
library(plotly)

#Load in dataset
info <- aggCampaignData('2016', candidate_ids)



#Function creates and returns a plotly pie chart
contribution_piechart <- function(candidateId) {
  
  #Filtering to desired candidate
  candidate_info <- filter(info, results.candidate_id == candidateId)
  
  #Formating data for pie chart
  ds <- data.frame(labels = c("Less than Two hundred", "Between Two hundred to Five hundred", "Between Five hundred to Fifteen hundred", "Between Fifteen hundred to Twenty Seven hundred"),
                 values = c(candidate_info$results.contributions_less_than_200[1], candidate_info$results.contributions_200_499[1], 
                  candidate_info$results.contributions_500_1499[1], candidate_info$results.contributions_1500_2699[1]))
  
  #Creating pie chart
  piechart <- plot_ly(ds, labels = labels, values = values, type = "pie") %>% 
    layout(title = "Contributions given to Candidate")


  return(piechart)
}


