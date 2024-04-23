#Fonction pour verifier s'il y a des erreurs dans le format de l'heure de debut.
#L'argument mistake_start designe un vecteur contenant toutes les valeurs de FALSE de la verification d'heure.
#Une valeur FALSE indique une erreur.

check_time_start <- function(mistakes_start) {
  if (length(mistake_start) > 0) {
    cat("Oui")
  } else {
    cat("Non")
  }
}

check_time_start(mistake_start)