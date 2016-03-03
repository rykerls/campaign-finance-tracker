library(shiny)

shinyUI(
  fluidPage(
  
    titlePanel("United States Campaign Finance Tracker"),
  
    sidebarPanel(
      
    ),
  
    mainPanel(
      tabsetPanel(
        tabPanel('Candidate 1'),
        tabPanel('Candidate 2'),
        tabPanel('Candidate 3'),
        tabPanel('Candidate 4'),
        tabPanel('Overview Data?')
      )
    )
  )
)