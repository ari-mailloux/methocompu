verifier_latitude <- function(latibas, colonne_lat, colonne_site_id) {
  resultats <- aggregate(latibas[[colonne_lat]] ~ latibas[[colonne_site_id]], latibas, function(x) length(unique(x)) == 1)
  return(resultats)
}
