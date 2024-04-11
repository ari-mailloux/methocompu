verifier_latitude <- function(df, colonne_lat, colonne_site_id) {
  resultats <- aggregate(df[[colonne_lat]] ~ df[[colonne_site_id]], df, function(x) length(unique(x)) == 1)
  return(resultats)
}
resultats_latitude <- verifier_latitude(df, "lat", "site_id")
