#Fonction pour corriger le nom vernaculaire francais des Carduelis pinus.
#Erreur: changer le nom vernaculaire francais Tarin pour Tarin des pins.
#L'argument car designe la base de donnees a corriger.
replace_car <- function(car) {
  for (i in 1:nrow(car)) {
    if (!is.na(car$valid_scientific_name[i]) && car$valid_scientific_name[i] == "Carduelis pinus") {
      car$vernacular_fr[i] <- "Tarin des pins"
    }
  }
  return(car)
}