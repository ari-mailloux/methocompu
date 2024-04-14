replace_anatidae <- function(can) {
  for (i in 1:nrow(can)) {
    if (!is.na(can$valid_scientific_name[i]) && can$valid_scientific_name[i] == "Anatidae") {
      can$vernacular_en[i] <- "Ducks"
      can$vernacular_fr[i] <- "Canards"
    }
  }
  return(can)
}

