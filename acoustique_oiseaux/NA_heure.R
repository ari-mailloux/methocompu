check_NA_heure <- function(mistake_obs, df) {
  erreur_format <- length(mistake_obs)  # Combien d'erreurs de format?
  intermed1 <- is.na(df$time_obs) 
  val.manquantes1 <- grep(TRUE, intermed1)
  valeurs_manquantes <- length(val.manquantes1)  # Combien de NA?
  cat("Il y a", valeurs_manquantes, "NA et", erreur_format, "erreurs de format ; toutes les erreurs de format sont donc des NA\n")
}

check_NA_heure(mistake_obs, df)