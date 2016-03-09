require(plotly)
require(dplyr)

source('../scripts/data-retrieval.r')
source('../scripts/utility.r')

<<<<<<< HEAD
contribution_bar_chart <- function(id, stack = FALSE) {
  candidate_data <- .get_candidate_info(id[1])
  
  if (!stack) {
    if (candidate_data$party == 'D') {
      bar_color <- toRGB('blue')
    } else if (candidate_data$party == 'R') {
      bar_color <- toRGB('red')
    }
  } else {
    bar_color <- NULL
  }
  
  
  if (stack) {
    chart_name <- 'Candidate Comparison'
  } else {
    chart_name <- candidate_data$name
  }
  
  bar_chart <- candidate_data$candidate %>% 
    plot_ly(type = 'bar', 
            x = prettify_results(colnames(candidate_data$candidate)), 
            y = as.numeric(candidate_data$candidate[1,]),
            marker = list(
              color = bar_color
            ),
            name = candidate_data$name) %>% 
    layout(title = chart_name,
           xaxis = list(
             title = 'Category'
           ),
           yaxis = list(
             title = 'Contribution Amount (USD)'
           ))
  
  if (stack) {
    sapply(candidate_ids[2:length(candidate_ids)], .stack_bars)
  }
  
  return(last_plot())
}

.stack_bars <- function(id) {
    candidate_info <- .get_candidate_info(id)
    add_trace(p = last_plot(),
              y = as.numeric(candidate_info$candidate[1,]),
              name = candidate_info$name)
}

.get_candidate_info <- function(id) {
  campaign <- getCampaignData('2016', candidate_ids) %>% 
    filter(results.candidate_id == id)
  
  candidate <- getCandidateData(candidate_ids) %>% 
    filter(results.id == id)
  
  joined <- left_join(candidate, campaign, by = c('results.id' = 'results.candidate_id', 'cycle'))
  
  selected_columns <- joined %>% 
    select(results.total_receipts.x, 
           results.total_disbursements.x,
           results.candidate_loans,
           results.total_from_individuals,
           results.total_from_pacs)
  
  data <- list(
    name = campaign$results.name,
    candidate = selected_columns,
    party = campaign$results.party
  )
  
    return(data)
}