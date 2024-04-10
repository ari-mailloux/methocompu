check_mistakes <- function(mistake_obs) {
  if (length(mistake_obs) > 0) {
    return("Oui")
  } else {
    return("Non")
  }
  cat("Est-ce qu'il y a des erreurs? :", resultat, "\n")
  return(resultat)
}
check_mistakes(mistake_obs)
