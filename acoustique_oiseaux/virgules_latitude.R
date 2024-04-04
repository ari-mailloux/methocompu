verifier_virgules <- function(df, lat) {
  indices <- grep(",", df$lat)
  if (length(indices) > 0) {
    return("Oui") # Présence d'au moins une virgule
  } else {
    return("Non") # Que des points
  }
}
resultat <- verifier_virgules(df, "lat")
cat("Virgules présentes :", resultat, "\n")