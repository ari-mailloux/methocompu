
######### Création du graphique d'observations de Paruline du Canada par heure
### observation_paru c'est le dataframe avec les donnees d'observation de paruline (paru)
### formatheure c'est la colonne du même dataframe avec les heures formattees (heure_formattee)
### nombre_obs_paru c'est la colonne avec le nombre d'observations de paruline par heure (nb_obs)
graph_2 <- function(observation_paru,formatheure,nombre_obs_paru) {
  #Retirer les NA
  par_donnees_non_na <- observation_paru[!is.na(observation_paru$formatheure), ]
  #Convertir format des données en heure
  par_donnees_non_na$formatheure <- as.POSIXct(par_donnees_non_na$formatheure, format = "%H:%M:%S")
  
  #Établissement des limites d'heures
  heures_completees_par <- data.frame(formatheure = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
  
  #Ajout des heures manquantes
  donnees_completees_par <- merge(heures_completees_par, par_donnees_non_na, by = "formatheure", all.x = TRUE)
  donnees_completees_par$nombre_obs_paru[is.na(donnees_completees_par$nombre_obs_paru)] <- 0
  
  #Création du graphique
  png("graph2.png")
  obs_par_cana_heure <- barplot(donnees_completees_par$nombre_obs_paru, 
                                names.arg = format(donnees_completees_par$formatheure, "%H:%M:%S"), 
                                ylab = "Nombre d'observation", 
                                xlab = "Heure", 
                                col = "skyblue",
                                ylim = c(0, 40),
                                las = 2,
                                cex.names = 0.6,
                                main = "Nombre d'observations de Cardellina\ncanadensis en fonction de l'heure")
  
  dev.off()
}
