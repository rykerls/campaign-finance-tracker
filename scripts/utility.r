#Use this file for any utility functions that might be useful throughout the project.

#Takes in a string and capitalizes the first letter of every word
.simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
}

#Takes in a vector containing keys from the json response and formats in a
#more aesthetically pleasing manner
prettify_results <- function(categories) {  
  categories <- gsub('(results.)|[.](x|y)', '', categories)
  categories <- gsub('_', ' ', categories)
  categories <- as.vector(sapply(categories, .simpleCap))
  return(categories)
}

get_candidate_writeup <- function(id) {
  return(paste0('text/', id, '.html'))
}
