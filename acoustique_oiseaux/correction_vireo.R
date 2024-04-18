#Fonction pour corriger l'erreur identifiee chez les Vireo.
#L'argument vir designe la base de donnees a corriger.
replace_vir <- function(vir) {
  for (i in 1:nrow(vir)) {
    if (!is.na(vir$valid_scientific_name[i]) && vir$valid_scientific_name[i] == "Vireo") {
      vir$vernacular_en[i] <- "Vireos"
      vir$vernacular_fr[i] <- "Vireo"
    }
  }
  return(vir)
}