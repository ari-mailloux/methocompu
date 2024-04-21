
######### Création du graphique d'observations par heure en utilisant les données filtrées

donnees_non_na <- heure[!is.na(heure$heure_formattee), ]
heure$heure_formattee <- as.POSIXct(heure$heure_formattee, format = "%H:%M:%S")
heures_completees <- data.frame(heure_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
head(heures_completees)
donnees_completees <- merge(heures_completees, donnees_non_na, by = "heure_formattee", all.x = TRUE)
head(donnees_completees)
donnees_completees$nb_obs[is.na(donnees_completees$nb_obs)] <- 0

obs_par_heure <- barplot(donnees_completees$nb_obs, 
                         names.arg = format(donnees_completees$heure_formattee, "%H:%M:%S"), 
                         ylab = "Nombre d'observation", 
                         xlab = "Heure", 
                         col = "skyblue",
                         ylim = c(0, 6000),
                         las = 2,
                         cex.names = 0.6,
                         main= "Nombre d'observations de tous les oiseaux\nconfondus en fonction de l'heure")

# Afficher le graphique
print(obs_par_heure)

#######Création du graphique d'observations de paruline du Canada par heure
par_donnees_non_na <- paru[!is.na(paru$heure_formattee), ]
par_donnees_non_na$heure_formattee <- as.POSIXct(par_donnees_non_na$heure_formattee, format = "%H:%M:%S")
heures_completees_par <- data.frame(heure_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
heures_completees_par <- data.frame(heure_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
donnees_completees_par <- merge(heures_completees_par, par_donnees_non_na, by = "heure_formattee", all.x = TRUE)
donnees_completees_par$nb_obs[is.na(donnees_completees_par$nb_obs)] <- 0
obs_par_cana_heure <- barplot(donnees_completees_par$nb_obs, 
                              names.arg = format(donnees_completees_par$heure_formattee, "%H:%M:%S"), 
                              ylab = "Nombre d'observation", 
                              xlab = "Heure", 
                              col = "skyblue",
                              ylim = c(0, 40),
                              las = 2,
                              cex.names = 0.6,
                              main = "Nombre d'observations de Cardellina\ncanadensis en fonction de l'heure")

# Afficher le graphique
print(obs_par_cana_heure)



# Création du graphique d'espèces par heure
div_non_na <- diversite[!is.na(diversite$heure_formattee), ]
div_non_na$heure_formattee <- as.POSIXct(div_non_na$heure_formattee, format = "%H:%M:%S")
heures_completees_div <- data.frame(heure_formattee = as.POSIXct(sprintf("%02d:00:00", 0:23), format = "%H:%M:%S"))
donnees_completees_div <- merge(heures_completees_div, div_non_na, by = "heure_formattee", all.x = TRUE)
donnees_completees_div$nb_valid_scientific_names[is.na(donnees_completees_div$nb_valid_scientific_names)] <- 0
div_par_heure <- barplot(donnees_completees_div$nb_valid_scientific_names, 
                         names.arg = format(donnees_completees_div$heure_formattee, "%H:%M:%S"), 
                         ylab = "Nombre d'espèces distinctes", 
                         xlab = "Heure", 
                         col = "skyblue",
                         ylim = c(0, 150),
                         las = 2,
                         cex.names = 0.6,
                         main = "Nombre d'espèces distinctes\nen fonction de l'heure")

# Afficher le graphique
print(div_par_heure)
