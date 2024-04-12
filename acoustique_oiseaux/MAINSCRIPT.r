#Ce scripte a été écrit pour les données portant sur les oiseaux.

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

#changer le titre de la colonne variable pour un terme plus adéquat
source("var_pres.R")

# ajout des colonnes du numéro d'observation (identificateur unique) et du type de projection
source("ajout_col.R")

# Vérifier qu'il y a que des points dans la latitude
source("virgules_latitude.R")

#Vérifier que chaque site a une seule latitude
source("site_lat.R")

#Vérifirer que la latitude se trouve dans le Québec (entre 45 et 63)
source("lat_qc.R")

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
source("correction_anatidae.R")
source("correction_dryobates.R")
source("correction_passeri.R")
source("correction_tarin.R")
source("correction_troglo.R")
source("correction_vireo.R")

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

#Requêtes SQL
source("requetes_SQL.R")


#Création des graphiques
source("graph_creation.R")

dbDisconnect(conn)
