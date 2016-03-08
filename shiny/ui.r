library(shiny)

source('../scripts/data-retrieval.r')

shinyUI(
  fluidPage(
  
    titlePanel("United States Campaign Finance Tracker"),
  
    sidebarPanel(
      
    ),
  
    mainPanel(
      tabsetPanel(
        tabPanel('Bernie Sanders',
                 plotlyOutput('plot1')
                 ),
        tabPanel('Hillary Clinton',
                 plotlyOutput('plot2')
                 ),
        tabPanel('Donald J. Trump',
                 plotlyOutput('plot3')
                 ),
        tabPanel('Ted Cruz',
                 plotlyOutput('plot4')
                 ),
        tabPanel('Overview Data?')
      )
    )
  )
)