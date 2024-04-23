#Fonction pour corriger l'erreur qui a ete identifiee chez les Passeriformes.
#L'argument pas correspond a la base de donnees.
correction_passeriformes<- function(pas) {
  for (i in 1:nrow(pas)) {
    if (!is.na(pas$valid_scientific_name[i]) && pas$valid_scientific_name[i] == "Passeriformes") {
      pas$vernacular_en[i] <- "Perching birds"
      pas$vernacular_fr[i] <- "Passereaux"
    }
  }
  return(pas)
}