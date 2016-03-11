library(shiny)
library(plotly)

source('scripts/data-retrieval.r')
source('scripts/contributions-bar-chart.r')
source('scripts/donations-map.r')
source('scripts/donations-pie.r')
source('scripts/utility.r')

function(input, output) {
  
  output$bar_chart <- renderPlotly({
    contribution_bar_chart(input$select_candidate)
  })
  
  output$map <- renderPlotly({
    donationMap(input$select_candidate)
  })
  
  output$pie <- renderPlotly({
    contribution_piechart(input$select_candidate)    
  })
  
  output$writeup <- renderUI({
    includeText(get_candidate_writeup(input$select_candidate))
  })
}