#Ce scripte a été écrit pour les données portant sur les oiseaux.

#Le répertoire de travail (working directory) doit être le dossier contenant tous les fichiers de données.
#Les scriptes R des fonctions doivent également s'y retrouver.

#importer base de données dans R

fichiers <- list.files(pattern = "\\.csv$")
dat <- lapply(fichiers, read.csv)

donnees_combinees <- do.call(rbind, dat)

#transformation des NULL en NA
source("null_vers_na.R")
df<-null_vers_na(donnees_combinees)

#normaliser le format des dates dans la base de données
source("convertir_date.R")
df$date_obs<-sapply(df$date_obs, convertir_date)

#transformer la colonne "variable" pour que les données soient en format booléen
source("bool.R")
df$variable<-sapply(df$variable, presence)
## erreur avec la ligne ci-dessus
#changer le titre de la colonne variable pour un terme plus adéquat
names(df)[names(df) == "variable"] <- "presence"

# ajout des colonnes du numéro d'observation (identificateur unique) et du type de projection
ID_obs<-c(1:nrow(df)) 
df$ID_obs<-ID_obs
# il faut mettre ça dans une fonction

df$projection<-"projection conique conforme de Lambert du Québec (SRCS=6622)"

# Vérifier qu'il y a que des points dans la latitude

source("virgules_latitude.R")

#Vérifier que chaque site a une seule latitude
latitude <- aggregate(lat ~ site_id, df, function(x) length(unique(x)) == 1)

#Vérifirer que la latitude se trouve dans le Québec (entre 45 et 63)
qc <- all(df$lat >= 45 & df$lat <= 63)

#Vérifier les combinaisons dans les espèces

#Création comb pour avoir seulement les colonnes d'intérêts (car normal que les autres infos soient différentes pour même espèce ex les sites)
comb <- data.frame(df$valid_scientific_name, df$vernacular_en, df$vernacular_fr, df$species, df$kingdom, df$phylum, df$family, df$genus, df$rank)

#regrouper les données par espèce
source("regroup.R")
resultats <- regroup(comb, "df.valid_scientific_name")# On a un dataframe par espèce. On a une liste de dataframes, chaque dataframe est une espèce
doub<-lapply(resultats, duplicated) # Vérifier si les données sont des doublons dans chacun des dataframes (c'est ce qu'on veut, que les infos soient pareilles)
    #normal que le premier est FALSE puisque c'est le premier doublon (les autres sont des doubles du premier, le premier est un non doublon)

#appliquer la fonction pour compter le nombre de faux (s'il y en a plus qu'un, il y a une erreur)
source("compter_faux.R")
erre<-lapply(doub, compter_faux) #applique la fonction dans la liste
    #erreur dans Anatidae, Dryobates pubescens, Passeriformes et Vireo

#correction des erreurs
source("correction_erreurs.R")

#Vérifier le format de l'heure d'observation
source("format_heure.R")
resultat_obs<-sapply(df$time_obs,verifier_format_heure)
mistake_obs <- grep(FALSE, resultat_obs)
source("erreur_heure.R") #ne veut pas s'afficher seule...
# il faut mettre check_mistakes(mistake_obs), je sais pas comment faire sans, mais c'est comme si je demandais
#d'appliquer la fonction sur le mistake_obs mais c'est déjà fait dans l'autre document...

#ça sort "Oui", il y a donc des erreurs

#Vérifier si les erreurs sont juste des NA
source("NA_heure.R")


#Vérifier le format de la colonne time_start
resultat_start<-sapply(df$time_start,verifier_format_heure)
mistake_start <- grep(FALSE, resultat_start) #il ne marche pas
source("time_start.R")

#ça sort "Non", il n'y a pas d'erreurs

library(dplyr)
#Vérifier le format de la colonne time_finish
resultat_finish<-sapply(df$time_finish,verifier_format_heure)
mistake_finish <- grep(FALSE, resultat_finish)
source("time_finish.R")

#ça sort "Oui", il y a erreur

#vérifier si les erreurs sont tout simplement des NA
source("NA_finish.R")

#Changer le nom de la colonne order pour ordre
names(df)[names(df) == "order"] <- "ordre"

##### Separation en tables ##### 
source("creation_tables.R")

library(RSQLite)

conn<-dbConnect(SQLite(), dbname="accousitque.db")

#Creation de la base de donnees
dbSendQuery(conn, "DROP TABLE effort_e;")
dbSendQuery(conn, "DROP TABLE obs;")
dbSendQuery(conn, "DROP TABLE site;")
dbSendQuery(conn, "DROP TABLE taxo;")
source("creation_db.R")

#Requête SQL qui permet de dire le nombre d'observation par heure
#Note: Il y a rien entre 13h et 19h. Aucun échantillonnage dans ces heures?
par_heure<- "
 SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
  FROM obs
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"

#Tableau avec le nombre d'observations selon l'heure
heure<-dbGetQuery(conn, par_heure)

donnees_non_na <- heure[!is.na(heure$heure_formattee), ]


# Création du graphique à barres en utilisant les données filtrées
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

#Requête SQL qui dit le nombre d'observation de la chouette rayée selon l'heure
paruline_canada<-"
  SELECT valid_scientific_name, STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
  FROM obs
  WHERE valid_scientific_name= 'Cardellina canadensis'
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"

#Sort le tableau avec le nombre d'observations de chouette rayée selon l'heure
obs_par_cana<-dbGetQuery(conn, paruline_canada)
head(obs_par_cana)

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



diversite<- "
 SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(DISTINCT valid_scientific_name) AS nb_valid_scientific_names
  FROM obs
  WHERE rank = 'species'
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"
diversite_heure<-dbGetQuery(conn, diversite)

head(diversite_heure)

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

dbDisconnect(conn)
