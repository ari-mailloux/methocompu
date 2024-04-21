######### Création du graphique d'observations par heure
graph_1 <- function(graph_obs) {
  #Retirer les NA
  donnees_non_na <- heure[!is.na(heure$heure_formattee), ]
  #Convertir format des données en heure
  heure$heure_formattee <- as.POSIXct(heure$heure_formattee, format = "%H:%M:%S")
  #Établissement des limites d'heures
  heures_completees <- data.frame(heure_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
  #Ajout des heures manquantes
  donnees_completees <- merge(heures_completees, donnees_non_na, by = "heure_formattee", all.x = TRUE)
  donnees_completees$nb_obs[is.na(donnees_completees$nb_obs)] <- 0
  #Création du graphique
  png("graph1.png")
  obs_par_heure <- barplot(donnees_completees$nb_obs, 
                           names.arg = format(donnees_completees$heure_formattee, "%H:%M:%S"), 
                           ylab = "Nombre d'observation", 
                           xlab = "Heure", 
                           col = "skyblue",
                           ylim = c(0, 6000),
                           las = 2,
                           cex.names = 0.6,
                           main= "Nombre d'observations de tous les oiseaux\nconfondus en fonction de l'heure")
  
  dev.off()
}
