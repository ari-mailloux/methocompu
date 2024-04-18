#Fonction pour determiner s'il y a des erreurs dans le format de l'heure.
#mistake est un vecteur contenant seulement les valeurs FALSE de la vérification du format de l'heure.
#La valeur FALSE indique une erreur de l'heure.
check_mistakes <- function(mistake) {
  if (length(mistake) > 0) {
    return("Oui")
  } else {
    return("Non")
  }
  cat("Est-ce qu'il y a des erreurs? :", resultat, "\n")
  return(resultat)
}

