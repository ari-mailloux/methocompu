graph_3 <- function(graph_obs) {
  #Retirer les NA
  div_non_na <- diversite[!is.na(diversite$heure_formattee), ]
  #Convertir format des données en heure
  div_non_na$heure_formattee <- as.POSIXct(div_non_na$heure_formattee, format = "%H:%M:%S")
  #Établissement des limites d'heures
  heures_completees_div <- data.frame(heure_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
  #Ajout des heures manquantes
  donnees_completees_div <- merge(heures_completees_div, div_non_na, by = "heure_formattee", all.x = TRUE)
  donnees_completees_div$nb_valid_scientific_names[is.na(donnees_completees_div$nb_valid_scientific_names)] <- 0
  #Création du graphique
  png("graph3.png")
  div_par_heure <- barplot(donnees_completees_div$nb_valid_scientific_names, 
                           names.arg = format(donnees_completees_div$heure_formattee, "%H:%M:%S"), 
                           ylab = "Nombre d'espèces distinctes", 
                           xlab = "Heure", 
                           col = "skyblue",
                           ylim = c(0, 150),
                           las = 2,
                           cex.names = 0.6,
                           main = "Nombre d'espèces distinctes\nen fonction de l'heure")
  
  dev.off()
}
