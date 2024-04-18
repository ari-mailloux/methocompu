#Fonction pour verifier s'il y a des erreurs dans le format de l'heure de fin.
#L'argument mistake_finish designe un vecteur contenant toutes les valeurs de FALSE de la verification d'heure.
#Une valeur FALSE indique une erreur.

check_time_finish <- function(mistake_finish) {
  if (length(mistake_finish) > 0) {
    cat("Oui")
  } else {
    cat("Non")
  }
}
check_time_finish(mistake_finish)