#ajout de la colonne projection
ajouter_projection <- function(based) {
  based$projection <- as.character("projection conique conforme de Lambert du Québec (SRCS=6622)")
  return(based)
}
