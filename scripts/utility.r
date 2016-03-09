#Use this file for any utility functions that might be useful throughout the project.


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
