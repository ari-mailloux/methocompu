#ajout de la colonne ID_obs
ajouter_ID_obs <- function(df) {
  df$ID_obs <- 1:nrow(df)
  return(df)
}
df <- ajouter_ID_obs(df)

#ajout de la colonne projection
ajouter_projection <- function(df) {
  df$projection <- "projection conique conforme de Lambert du Québec (SRCS=6622)"
  return(df)
}
df<- ajouter_projection(df)