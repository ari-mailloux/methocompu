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

df$projection<-"projection conique conforme de Lambert du Québec (SRCS=6622)"

# Vérifier qu'il y a que des points dans la latitude

source("virgules_latitude.R")

#Vérifier que chaque site a une seule latitude
latitude <- aggregate(lat ~ site_id, df, function(x) length(unique(x)) == 1)
latitude

#Vérifirer que la latitude se trouve dans le Québec (entre 45 et 63)
qc <- all(df$lat >= 45 & df$lat <= 63)
qc

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
if (length(mistake_obs) > 0) {
  cat("Oui")
} else {
  cat("Non")
}
#ça sort "Oui", il y a donc des erreurs

#Vérifier si les erreurs sont juste des NA
length(mistake_obs) #combien d'erreurs de format?
intermed1 <- is.na(df$time_obs) 
val.manquantes1 <- grep(TRUE,intermed1)
length(val.manquantes1) #combien de NA?
#Il y a 2515 NA et 2515 erreurs de format ; toutes les erreurs de format sont donc des NA

#Vérifier le format de la colonne time_start
resultat_start<-sapply(df$time_start,verifier_format_heure)
mistake_start <- grep(FALSE, resultat_start)
if (length(mistake_start) > 0) {
  cat("Oui")
} else {
  cat("Non")
}
#ça sort "Non", il n'y a pas d'erreurs
library(dplyr)
#Vérifier le format de la colonne time_finish
resultat_finish<-sapply(df$time_finish,verifier_format_heure)
mistake_finish <- grep(FALSE, resultat_finish)
if (length(mistake_finish) > 0) {
  cat("Oui")
} else {
  cat("Non")
}
#ça sort "Oui", il y a erreur

#vérifier si les erreurs sont tout simplement des NA
length(mistake_finish) #combien d'erreurs de format?
intermed <- is.na(df$time_finish) 
val.manquantes <- grep(TRUE,intermed)
length(val.manquantes) #combien de valeurs manquantes?
#puisqu'il y a 1 erreur de format et 1 valeur NA, la seule erreur de format est la valeur NA.

#Changer le nom de la colonne order pour ordre
names(df)[names(df) == "order"] <- "ordre"

##### Separation en tables ##### 
source("creation_tables.R")

library(RSQLite)

conn<-dbConnect(SQLite(), dbname="accousitque.db")

#Creation de la table qui contient les informations relatives aux sites d'echantillonage
dbSendQuery(conn, "DROP TABLE site;")
source("db_site.R")

#Creation de la table qui contient les informations relatives a la taxonomie des especes
dbSendQuery(conn, "DROP TABLE taxo;")
source("db_taxo.R")

#Creation de la table qui contient les informations relatives a l'effort d'echantillonnage
dbSendQuery(conn, "DROP TABLE effort_e;")
source("db_effort_e.R")

#Creation de la table qui contient les informations relatives aux observations
dbSendQuery(conn, "DROP TABLE obs;")
source("db_obs.R")


dbWriteTable(conn, append = TRUE, name = "site", value = endroit_u, row.names = FALSE)
dbWriteTable(conn, append = TRUE, name = "taxo", value = taxo_u, row.names = FALSE)
dbWriteTable(conn, append = TRUE, name = "obs", value = Oiseau, row.names = FALSE)
dbWriteTable(conn, append = TRUE, name = "effort_e", value = effort_u, row.names = FALSE)

#Requête SQL qui permet de dire le nombre d'observation par heure
#Note: Il y a rien entre 13h et 19h. Aucun échantillonnage dans ces heures?
par_heure<- "
 SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
  FROM obs
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"

#Tableau avec le nombre d'observations selon l'heure
heure<-dbGetQuery(conn, par_heure)

#Requête SQL qui dit le nombre d'observation de la chouette rayée selon l'heure
chouette_rayee<-"
  SELECT valid_scientific_name, STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
  FROM obs
  WHERE valid_scientific_name= 'Strix varia'
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"

#Sort le tableau avec le nombre d'observations de chouette rayée selon l'heure
obs_chouette<-dbGetQuery(conn, chouette_rayee)

dbDisconnect(conn)
