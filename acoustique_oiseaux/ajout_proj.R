#Ajout de la colonne projection pour preciser le type de projection cartographique.
#L'argument based designe le nom de la base de donnees.
ajouter_projection <- function(based) {
  based$projection <- as.character("projection conique conforme de Lambert du Québec (SRCS=6622)")
  return(based)
}
