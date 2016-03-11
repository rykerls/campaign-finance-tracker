library(shiny)
library(plotly)

source('../scripts/data-retrieval.r')

shinyUI(
  fluidPage(
  
    titlePanel("United States Campaign Finance Tracker"),
  
    sidebarPanel(
      selectInput('select_candidate', 'Candidate', c(
        'Bernie Sanders' = candidate_ids[1],
        'Hillary Clinton' = candidate_ids[2],
        'Donald J. Trump' = candidate_ids[3],
        'Ted Cruz' = candidate_ids[4]
      ))
    ),
  
    mainPanel(
      plotlyOutput('bar_chart'),
      plotlyOutput('map')
    )
  )
)