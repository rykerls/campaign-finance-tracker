require(plotly)
require(dplyr)

source('scripts/data-retrieval.r')
source('scripts/utility.r')

#Creates a bar chart showing the spending and receiving of given political 
#candidates. id is their FEC id, this can be a vector of as many ids as you 
#like. Simply set stack to true and the function will plot them all.
contribution_bar_chart <- function(id, stack = FALSE) {
  candidate_data <- .get_candidate_info(id[1])
  
  #Set color according to the candidates party. If we're plotting multiple
  #candidates, set the color to null so plotly will just choose one.
  if (!stack) {
    if (candidate_data$party == 'D') {
      bar_color <- toRGB('blue')
    } else if (candidate_data$party == 'R') {
      bar_color <- toRGB('red')
    }
  } else {
    bar_color <- NULL
  }
  
  #Name the chart appropriately
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
  #add traces for each additional candidate
  if (stack) {
    sapply(candidate_ids[2:length(candidate_ids)], .stack_bars)
  }
  
  return(last_plot())
}

#Add a candidate to the bar chart
.stack_bars <- function(id) {
    candidate_info <- .get_candidate_info(id)
    add_trace(p = last_plot(),
              y = as.numeric(candidate_info$candidate[1,]),
              name = candidate_info$name)
}

#Concatenate the relevant information from multiple sources.
#Returns a list containing the relevant information
.get_candidate_info <- function(id) {
  campaign <- aggCampaignData('2016', candidate_ids) %>% 
    filter(results.candidate_id == id)
  
  candidate <- getCandidateData(candidate_ids, '2016') %>% 
    filter(results.id == id)
  
  #Join the two data frames together so both their data can be plotted.
  joined <- left_join(candidate, campaign, 
                      by = c('results.id' = 'results.candidate_id', 'cycle'))
  
  #Select the appropriate columns to be plotted. 
  #Add or remove here to change which columns are plotted
  selected_columns <- joined %>% 
    select(results.total_receipts.x, 
           results.total_disbursements.x,
           results.candidate_loans,
           results.total_from_individuals,
           results.total_from_pacs)
  
  data <- list(
    name = campaign$results.name,  #Human readable name of the candidate
    candidate = selected_columns,  #Data columns that will be plotted
    party = campaign$results.party #The single letter representing the candidates party
  )
  
    return(data)
}