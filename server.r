library(shiny)
library(plotly)

source('scripts/data-retrieval.r')
source('scripts/contributions-bar-chart.r')
source('scripts/donations-map.r')

function(input, output) {
  output$bar_chart <- renderPlotly({
    contribution_bar_chart(input$select_candidate)
  })
  
  output$map <- renderPlotly({
    donationMap(input$select_candidate)
  })
}