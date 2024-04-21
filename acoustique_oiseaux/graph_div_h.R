######### Création du graphique de la diversité (nombre d'espèces distinctes) par heure
### observation_div c'est le dataframe avec les donnees sur les heures d'observation et le nombre d'espèces distinctes observées(diversite)
### heureformat c'est la colonne de diversite avec les heures formattees (heure_formattees)
### nomscientific c'est la colonne avec le nombre d'espèces distinctes par heure (valid_scientific_name)
graph_3 <- function(observation_div, heureformat, nomscientific) {
  #Retirer les NA
  div_non_na <- observation_div[!is.na(observation_div$heureformat), ]
  #Convertir format des données en heure
  div_non_na$heureformat <- as.POSIXct(div_non_na$heureformat, format = "%H:%M:%S")
  #Établissement des limites d'heures
  heures_completees_div <- data.frame(heureformat = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
  #Ajout des heures manquantes
  donnees_completees_div <- merge(heures_completees_div, div_non_na, by = "heureformat", all.x = TRUE)
  donnees_completees_div$nomscientific[is.na(donnees_completees_div$nomscientific)] <- 0
  #Création du graphique
  
  div_par_heure <- barplot(donnees_completees_div$nomscientific, 
                           names.arg = format(donnees_completees_div$heureformat, "%H:%M:%S"), 
                           ylab = "Nombre d'espèces distinctes", 
                           xlab = "Heure", 
                           col = "skyblue",
                           ylim = c(0, 150),
                           las = 2,
                           cex.names = 0.6,
                           main = "Figure 3. Nombre d'espèces distinctes\nen fonction de l'heure")
  png("graph3.png")
  dev.off()
}
