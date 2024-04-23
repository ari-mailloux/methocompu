#Fonction pour verifier que toutes les valeurs de latitude se trouvent au Quebec.
#L'argument queb designe la base de donnees a verifier.
#colonne_lat est la colonne contenant les valeurs de latitude. 

verifier_qc <- function(queb, colonne_lat) {
  qc <- all(queb[[colonne_lat]] >= 45 & queb[[colonne_lat]] <= 63)
  if(qc) {
    cat("oui, les latitudes sont dans le Qc")
  } else {
    cat("non, les latitudes ne sont pas dans le Qc")
  }
}

