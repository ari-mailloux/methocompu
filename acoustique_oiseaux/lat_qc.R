verifier_qc <- function(df, colonne_lat) {
  qc <- all(df[[colonne_lat]] >= 45 & df[[colonne_lat]] <= 63)
  if(qc) {
    cat("oui, les latitudes sont dans le Qc")
  } else {
    cat("non, les latitudes ne sont pas dans le Qc")
  }
}
resultat_qc <- verifier_qc(df, "lat")
