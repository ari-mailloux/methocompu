#fonction pour aller changer les dates dans les bases de données.
#L'argument date_string correspond a la colonne du dataframe contenant des valeurs de date.
convertir_date <- function(date_string) {
  # Vérifier si la date est au format "jour/mois/année" ou "année/mois/jour"
  if (grepl("/", date_string)) {
    elements_date <- unlist(strsplit(date_string, "/"))
    # Convertir en format "année-mois-jour"
    date_modif <- paste(elements_date[3], elements_date[2], elements_date[1], sep = "-")
  } else if (grepl("-", date_string)) {
    elements_date <- unlist(strsplit(date_string, "-"))
    # Convertir en format "année-mois-jour"
    date_modif <- paste(elements_date[1], elements_date[2], elements_date[3], sep = "-")
  } else {
    # Si le format n'est pas reconnu, retourner la date d'origine
    date_modif <- date_string
  }
  return(date_modif)
}
