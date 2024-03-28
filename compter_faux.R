#fonction pour compter le nombre de faux
compter_faux <- function(erreur) {
  nb_faux <- sum(!as.logical(unlist(erreur)))
  return(nb_faux)
}