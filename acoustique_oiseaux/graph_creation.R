######### Création du graphique d'observations par heure en utilisant les données filtrées
donnees_non_na <- obs_heure[!is.na(obs_heure$heure_formattee), ]
# Créer un vecteur contenant toutes les heures que vous voulez afficher
toutes_heures <- format(seq(from=min(donnees_non_na$heure_formattee), 
                            to=max(donnees_non_na$heure_formattee), 
                            by="1 hour"), 
                        "%H:%M:%S")
# Ajouter les heures sans observation
donnees_completes <- data.frame(heure_formattee = toutes_heures, 
                                nb_obs = 0)
# Fusionner avec les données existantes
donnees_completes <- merge(donnees_completes, 
                           donnees_non_na, 
                           by = "heure_formattee", 
                           all.x = TRUE)
# Trier les données par heure
donnees_completes <- donnees_completes[order(donnees_completes$heure_formattee), ]

#Créer le graphique
obs_par_heure <- barplot(donnees_non_na$nb_obs, 
                         names.arg = donnees_non_na$heure_formattee, 
                         ylab = "Nombre d'observation", 
                         xlab = "Heure", 
                         col = "skyblue",
                         ylim = c(0, 6000),
                         las = 2,
                         cex.names = 0.6,
                         main= "Nombre d'observations de les tous oiseaux\nconfondus en fonction de l'heure")

# Afficher le graphique
print(obs_par_heure)

#######Création du graphique d'observations de paruline du Canada par heure
par_donnees_non_na <- obs_par_cana[!is.na(obs_par_cana$heure_formattee), ]

obs_par_cana_heure <- barplot(par_donnees_non_na$nb_obs, 
                              names.arg = par_donnees_non_na$heure_formattee, 
                              ylab = "Nombre d'observation", 
                              xlab = "Heure", 
                              col = "skyblue",
                              ylim = c(0, 40),
                              las = 2,
                              cex.names = 0.6,
                              main= "Nombre d'observations de Cardellina canadensis\nen fonction de l'heure")


# Afficher le graphique
print(obs_par_cana_heure)



# Création du graphique d'espèces par heure
div_non_na <- diversite_heure[!is.na(diversite_heure$heure_formattee), ]

div_par_heure <- barplot(div_non_na$nb_valid_scientific_names, 
                         names.arg = div_non_na$heure_formattee, 
                         ylab = "Nombre d'espèces distinctes", 
                         xlab = "Heure", 
                         col = "skyblue",
                         ylim = c(0, 150),
                         las = 2,
                         cex.names = 0.6,
                         main= "Nombre d'espèces\nen fonction de l'heure")
print(div_par_heure)
