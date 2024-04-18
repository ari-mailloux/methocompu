#Ajout de la colonne ID_obs qui fournit un identifiant unique a chaque observations.
#L'argument base est le nom de la base de donnees.
ajouter_ID_obs <- function(base) {
  base$ID_obs <- 1:nrow(base)
  return(base)
}
