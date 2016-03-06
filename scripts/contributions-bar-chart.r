require(plotly)
require(dplyr)

source('scripts/data-retrieval.r')

contribution_bar_chart <- function(id) {
  candidate <- getCandidateData('2016-03-04') %>% 
    filter(results.id == id)
    
  selected_columns <- candidate %>% 
    select(results.total_receipts, results.total_from_individuals, 
           results.total_from_pacs, results.candidate_loans, 
           results.total_contributions, results.total_disbursements)
  
  candidate %>% 
    plot_ly(type = 'bar', 
            x = colnames(selected_columns), 
            y = as.numeric(selected_columns[1,])) %>% 
    layout(title = candidate$results.name)
}