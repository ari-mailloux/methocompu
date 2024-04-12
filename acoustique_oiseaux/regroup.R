# Créer une fonction pour regrouper les données par espèces
regroup <- function(data_fra, col_e) {
  grouped_data <- split(data_fra, data_fra[["valid_scientific_name"]]) # Utiliser split pour regrouper les données par le nom scientifique
  return(grouped_data)
}