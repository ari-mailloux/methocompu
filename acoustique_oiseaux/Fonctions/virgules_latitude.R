#Fonction pour verifier que les nombres a decimales utilisent un point et non une virgule.
#L'argument datafr designe la base de donnees a verifier.
#L'argument col designe la colonne a verifier dans la base de donnees.

verifier_virgules <- function(datafr, col) {
  indices <- grep(",", datafr[[col]])
  if (length(indices) > 0) {
    datafr[[col]] <- gsub(",", ".", datafr[[col]])
    return(datafr) 
  } else {
    return("Non")
  }
}