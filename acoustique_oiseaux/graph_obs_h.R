######### Création du graphique d'observations par heure
graph_1 <- function(graph_obs) {
  # Créer un vecteur contenant toutes les heures que vous voulez afficher
  toutes_heures <- format(seq(from=min(graph_obs$heure_formattee), 
                              to=max(graph_obs$heure_formattee), 
                              by="1 hour"), 
                          "%H:%M:%S")
  # Ajouter les heures sans observation
  donnees_completes <- data.frame(heure_formattee = toutes_heures, 
                                  nb_obs = 0)
  # Fusionner avec les données existantes
  donnees_completes <- merge(donnees_completes, 
                             graph_obs, 
                             by = "heure_formattee", 
                             all.x = TRUE)
  # Trier les données par heure
  donnees_completes <- donnees_completes[order(donnees_completes$heure_formattee), ]
  
  #Créer le graphique
  png("graph1.png")
  graph_obs_par_heure <- barplot(donnees_completes$nb_obs, 
                           names.arg = donnees_completes$heure_formattee, 
                           ylab = "Nombre d'observation", 
                           xlab = "Heure", 
                           col = "skyblue",
                           ylim = c(0, 6000),
                           las = 2,
                           cex.names = 0.6,
                           main= "Nombre d'observations de les tous oiseaux\nconfondus en fonction de l'heure")
  
  dev.off()
}
