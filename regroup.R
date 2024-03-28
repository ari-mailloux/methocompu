# Créer une fonction pour regrouper les données par espèces
regroup <- function(data, colonne) {
  grouped_data <- split(data, comb[["df.valid_scientific_name"]]) # Utiliser split pour regrouper les données par le nom scientifique
  return(grouped_data)
}