require(plotly)
require(dplyr)

source('../scripts/data-retrieval.r')
source('../scripts/utility.r')

contribution_bar_chart <- function(id) {
  campaign <- getCampaignData('2016', '2016-03-05', candidate_ids) %>% 
    filter(results.candidate_id == id)
  
  candidate <- getCandidateData('2016-03-04') %>% 
    filter(results.id == id)
  
  joined <- left_join(candidate, campaign, by = c('results.id' = 'results.candidate_id', 'cycle'))
    
  selected_columns <- joined %>% 
    select(results.total_receipts.x, 
           results.total_disbursements.x,
           results.candidate_loans,
           results.total_from_individuals,
           results.total_from_pacs)
  
  bar_color <- NULL
  if (campaign$results.party == 'D') {
    bar_color <- toRGB('blue')
  } else if (campaign$results.party == 'R') {
    bar_color <- toRGB('red')
  }
  
  selected_columns %>% 
    plot_ly(type = 'bar', 
            x = prettify_results(colnames(selected_columns)), 
            y = as.numeric(selected_columns[1,]),
            marker = list(
              color = bar_color
            )) %>% 
    layout(title = campaign$results.name,
           xaxis = list(
             title = 'Category'
           ),
           yaxis = list(
             title = 'Contribution Amount (USD)'
           )) %>% 
    return()
}