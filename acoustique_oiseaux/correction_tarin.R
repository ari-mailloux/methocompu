#nom vernaculaire francais des Carduelis pinus
#erreur: changer le nom vernaculaire franÃ§ais Tarin pour Tarin des pins
replace_car <- function(car) {
  for (i in 1:nrow(car)) {
    if (!is.na(car$valid_scientific_name[i]) && car$valid_scientific_name[i] == "Carduelis pinus") {
      car$vernacular_fr[i] <- "Tarin des pins"
    }
  }
  return(car)
}

