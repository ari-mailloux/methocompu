#fonction pour compter le nombre de faux
#L'argument erreur désigne un vecteur qui indique si chaque nom scientifique est 
#accompagné d'une seule combinaison de noms vernaculaires et de niveaux taxonomiques
compter_faux <- function(erreur) {
  nb_faux <- sum(!as.logical(unlist(erreur)))
  return(nb_faux)
}
