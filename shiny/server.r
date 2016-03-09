library(shiny)
library(plotly)

source('../scripts/data-retrieval.r')
source('../scripts/contributions-bar-chart.r')

function(input, output) {
  output$plot1 <- renderPlotly({
    contribution_bar_chart(candidate_ids[1])
  })
  
  output$plot2 <- renderPlotly({
    contribution_bar_chart(candidate_ids[2])
  })
  
  output$plot3 <- renderPlotly({
    contribution_bar_chart(candidate_ids[3])
  })
  
  output$plot4 <- renderPlotly({
    contribution_bar_chart(candidate_ids[4])
  })
  
  output$combined_bar <- renderPlotly({
    contribution_bar_chart(candidate_ids, stack = TRUE)
  })
}