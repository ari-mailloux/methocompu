#Fonction pour corriger l'erreur identifiee chez les troglodytes des forets.
#L'argument tro designe la base de donnees a corriger.
replace_tro <- function(tro) {
  for (i in 1:nrow(tro)) {
    if (!is.na(tro$vernacular_fr[i]) && tro$vernacular_fr[i] == "Troglodyte des forêts") {
      tro$vernacular_en[i] <- "Winter wren"
    }
  }
  return(tro)
}