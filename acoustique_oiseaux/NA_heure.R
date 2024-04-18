#Fonction confirmer si toutes les erreurs de format dans l'heure d'observation sont des valeurs manquantes.
#L'argument nah est un vecteur contenant toutes les valeurs FALSE de la verification du format.
#Une valeur FALSE indique une erreur.

check_NA_heure <- function(nah) {
  erreur_format <- length(nah)  # Combien d'erreurs de format?
  intermed1 <- is.na(nah$time_obs) 
  val.manquantes1 <- grep(TRUE, intermed1)
  valeurs_manquantes <- length(val.manquantes1)  # Combien de NA?
  cat("Il y a", valeurs_manquantes, "NA et", erreur_format, "erreurs de format\n")
}
