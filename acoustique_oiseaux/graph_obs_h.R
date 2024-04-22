######### Création du graphique d'observations par heure
### donnees_heure c'est le dataframe avec les donnees sur les heures d'observation (heure)
### col_formattee c'est la colonne de donnees_heure avec les heures formattees (col_formattee)
### col_col_nb_obs c'est la colonne avec le nombre d'observations par heure (col_nb_obs)
graph_1 <- function(donnees_heure,col_formattee,col_nb_obs) {
  #Retirer les NA
  donn_non_na <- donnees_heure[!is.na(donnees_heure$col_formattee), ]
  #Convertir format des données en heure
  donnees_heure$col_formattee <- as.POSIXct(donnees_heure$col_formattee, format = "%H:%M:%S")
  #Établissement des limites d'heures
  heures_completees <- data.frame(col_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
  #Ajout des heures manquantes
  donnees_completees <- merge(heures_completees, donn_non_na, by = "col_formattee", all.x = TRUE)
  donnees_completees$col_nb_obs[is.na(donnees_completees$col_nb_obs)] <- 0
  #Création du graphique
  obs_par_heure <- barplot(donnees_completees$col_nb_obs, 
                           names.arg = format(donnees_completees$col_formattee, "%H:%M:%S"), 
                           ylab = "Nombre d'observation", 
                           xlab = "Heure", 
                           col = "skyblue",
                           ylim = c(0, 6000),
                           las = 2,
                           cex.names = 0.6,
                           main= "Figure 1. Nombre d'observations de tous les oiseaux\nconfondus en fonction de l'heure")
  png("graph1.png")
  print(obs_par_heure)
  dev.off()
}
