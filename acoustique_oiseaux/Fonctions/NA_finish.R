#Fonction pour verifier si toutes les erreurs de format d'heure sont des valeurs manquantes (NA).
#L'argument mistake_finish est un vecteur contenant toutes les valeurs FALSE de la verification du format.
#Une valeur FALSE indique une erreur.

check_errors_finish <- function(mistake_finish, df) {
  erreur_format <- length(mistake_finish)  # Combien d'erreurs de format?
  intermed <- is.na(df$time_finish) 
  val.manquantes <- grep(TRUE, intermed)
  valeurs_manquantes <- length(val.manquantes)  # Combien de valeurs manquantes?
  cat("Il y a", valeurs_manquantes, "valeurs manquantes et", erreur_format, "erreurs de format \n")
}
check_errors_finish(mistake_finish, df)