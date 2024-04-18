#Fonction pour corriger l'erreur identifiée dans les Dryobates pubescens.
#L'argument dry designe la base de donnees.
replace_dry<- function(dry) {
  for (i in 1:nrow(dry)) {
    if (!is.na(dry$valid_scientific_name[i]) && dry$valid_scientific_name[i] == "Dryobates pubescens") {
      dry$vernacular_en[i] <- "Downy woodpecker"
      dry$vernacular_fr[i] <- "Pic mineur"
    }
  }
  return(dry)
}