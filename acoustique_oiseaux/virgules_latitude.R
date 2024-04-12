verifier_virgules <- function(datafr, col) {
  indices <- grep(",", datafr[[col]])
  if (length(indices) > 0) {
    datafr[[col]] <- gsub(",", ".", datafr[[col]])
    return(datafr) 
  } else {
    return("Non")
  }
}