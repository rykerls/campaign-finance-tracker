library(shiny)
library(ggplot2)

shinyUI(
  fluidPage(
  
    titlePanel("United States Campaign Finance Tracker"),
  
    sidebarPanel(
    
    ),
  
    mainPanel(
      plotOutput('plot')
    )
  )
)