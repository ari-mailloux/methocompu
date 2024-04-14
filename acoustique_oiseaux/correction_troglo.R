replace_tro <- function(tro) {
  for (i in 1:nrow(tro)) {
    if (!is.na(tro$vernacular_fr[i]) && tro$vernacular_fr[i] == "Troglodyte des forêts") {
      tro$vernacular_en[i] <- "Winter wren"
    }
  }
  return(tro)
}
