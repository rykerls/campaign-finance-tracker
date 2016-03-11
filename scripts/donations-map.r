########################
# Ryker Schwartzenberger
# Patrick Smith
# Laura Rickey
# Luke Baker
# INFO-498F
# Final Project
########################
#This script retruns a map of the US with the given canidates donations from each state. 
#It can also return a map with each state displaying the canidate who won in their state.

#Loading needed packages.
library(plotly)
library(dplyr)

#Loading needed function and setting global settings.
source('scripts/data-retrieval.r')
options(stringsAsFactors = FALSE)

#Pulling Data
aggData <- aggStateData('2016')

#Static map settings
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

#This function returns the plotly choropleth of the given canidates donation data by state.
donationMap <- function(id) {
  
  #Filtering Data to that of the specified canidate
  canidateData <- filter(aggData, gsub('(/candidates/)|(.json)', '', aggData$results.candidate) == id)
  #Creating the hover-over text
  hover = with(canidateData, paste(results.full_name,'<br>',results.state, '<br>', 'Donations: ', results.total, '<br>', '# of Donations ', results.contribution_count))
  
  #Creating the plotly map
  p <- plot_ly(canidateData, z = results.total, text = hover, locations = results.state,
              type = 'choropleth', locationmode = 'USA-states', color = results.total,
              colors = mapColors(canidateData$results.full_name), colorbar = list(title = 'USD')) %>% 
    layout(title = '2016 Election Donations by State', geo = g)
  return(p)    
}

#Helper function that returns what color scheme to use based on party
#affiliation of the canidate.
mapColors <- function(colorString) {
  if (colorString == 'Bernie Sanders' || colorString == 'Hillary Clinton') {
    c <- 'Blues'
  } else {
    c <- 'RdBu'
  }
  
  return(c)
}