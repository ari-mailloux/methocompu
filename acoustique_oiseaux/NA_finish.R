check_errors_finish <- function(mistake_finish, df) {
  erreur_format <- length(mistake_finish)  # Combien d'erreurs de format?
  intermed <- is.na(df$time_finish) 
  val.manquantes <- grep(TRUE, intermed)
  valeurs_manquantes <- length(val.manquantes)  # Combien de valeurs manquantes?
  cat("Il y a", valeurs_manquantes, "valeurs manquantes et", erreur_format, "erreurs de format ; la seule erreur de format est la valeur NA.\n")
}
check_errors_finish(mistake_finish, df)