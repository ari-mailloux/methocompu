######### Création du graphique d'observations de Paruline du Canada par heure
graph_2 <- function(graph_obs) {
  #Retirer les NA
  par_donnees_non_na <- paru[!is.na(paru$heure_formattee), ]
  #Convertir format des données en heure
  par_donnees_non_na$heure_formattee <- as.POSIXct(par_donnees_non_na$heure_formattee, format = "%H:%M:%S")
  
  #Établissement des limites d'heures
  heures_completees_par <- data.frame(heure_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
  
  #Ajout des heures manquantes
  donnees_completees_par <- merge(heures_completees_par, par_donnees_non_na, by = "heure_formattee", all.x = TRUE)
  donnees_completees_par$nb_obs[is.na(donnees_completees_par$nb_obs)] <- 0
  
  #Création du graphique
  png("graph2.png")
  obs_par_cana_heure <- barplot(donnees_completees_par$nb_obs, 
                                names.arg = format(donnees_completees_par$heure_formattee, "%H:%M:%S"), 
                                ylab = "Nombre d'observation", 
                                xlab = "Heure", 
                                col = "skyblue",
                                ylim = c(0, 40),
                                las = 2,
                                cex.names = 0.6,
                                main = "Nombre d'observations de Cardellina\ncanadensis en fonction de l'heure")
  
  dev.off()
}
