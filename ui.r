library(shiny)
library(plotly)

source('scripts/data-retrieval.r')

shinyUI(
  fluidPage(
    tags$head(tags$script(src='https://pixel.propublica.org/pixel.js')),
    titlePanel("2016 Presidential Campaign Finance Tracker"),
  
    sidebarPanel(
      selectInput('select_candidate', 'Candidate', c(
        'Bernie Sanders' = candidate_ids[1],
        'Hillary Clinton' = candidate_ids[2],
        'Donald J. Trump' = candidate_ids[3],
        'Ted Cruz' = candidate_ids[4]
      )),
      uiOutput('writeup')
    ),
  
    mainPanel(
      plotlyOutput('bar_chart'),
      br(),
      plotlyOutput('map'),
      br(),
      plotlyOutput('pie'),
      a('Data by ProPublica', href = 'https://www.propublica.org/data/')
    )
  )
)