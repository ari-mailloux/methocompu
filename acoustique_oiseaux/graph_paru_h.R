######### Création du graphique d'observations de Paruline du Canada par heure
graph_2 <- function(observation_paru,formatheure,nombre_obs_paru) {
  #Retirer les NA
  par_donnees_non_na <- observation_paru[!is.na(observation_paru$formatheure), ]
  #Convertir format des données en heure
  par_donnees_non_na$formatheure <- as.POSIXct(par_donnees_non_na$formatheure, format = "%H:%M:%S")
  
  #Établissement des limites d'heures
  heures_completees_par <- data.frame(formatheure = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
  
  #Ajout des heures manquantes
  donnees_completees_par <- merge(heures_completees_par, par_donnees_non_na, by = "formatheure", all.x = TRUE)
  donnees_completees_par$nb_obs[is.na(donnees_completees_par$nb_obs)] <- 0
  
  #Création du graphique
  png("graph2.png")
  obs_par_cana_heure <- barplot(donnees_completees_par$nb_obs, 
                                names.arg = format(donnees_completees_par$formatheure, "%H:%M:%S"), 
                                ylab = "Nombre d'observation", 
                                xlab = "Heure", 
                                col = "skyblue",
                                ylim = c(0, 40),
                                las = 2,
                                cex.names = 0.6,
                                main = "Figure 2. Nombre d'observations de Cardellina\ncanadensis en fonction de l'heure")
  
  dev.off()
}
