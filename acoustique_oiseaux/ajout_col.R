#ajout de la colonne ID_obs
ajouter_ID_obs <- function(base) {
  base$ID_obs <- 1:nrow(base)
  return(base)
}
