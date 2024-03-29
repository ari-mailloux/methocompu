#Ce scripte a été écrit pour les données portant sur les oiseaux.

#Le répertoire de travail (working directory) doit être le dossier contenant tous les fichiers de données.
#Les scriptes R des fonctions doivent également s'y retrouver.

#importer base de données dans R
fichiers <- list.files(pattern = "\\.csv$")
dat <- lapply(fichiers, read.csv)

donnees_combinees <- do.call(rbind, dat)

#transformation des NULL en NA
source("fonctions/NULL_NA.R")
df<-NULL_NA(donnees_combinees)

#normaliser le format des dates dans la base de données
source("fonctions/convertir_date.R")
df$date_obs<-sapply(df$date_obs, convertir_date)

#transformer la colonne "variable" pour que les données soient en format booléen
source("fonctions/bool.R")
df$variable<-sapply(df$variable, presence)
## erreur avec la ligne ci-dessus
#changer le titre de la colonne variable pour un terme plus adéquat
names(df)[names(df) == "variable"] <- "presence"

# ajout des colonnes du numéro d'observation (identificateur unique) et du type de projection
ID_obs<-c(1:nrow(df)) 
df$ID_obs<-ID_obs

df$projection<-"projection conique conforme de Lambert du Québec (SRCS=6622)"

# Vérifier qu'il y a que des points dans la latitude
virgules <- grep(",", df$lat)
if (length(virgules) > 0) {
  cat("Oui") #présence d'au moins une virgule
} else {
  cat("Non") #que des points
}

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
source("fonctions/regroup.R")
resultats <- regroup(comb, "df.valid_scientific_name")# On a un dataframe par espèce. On a une liste de dataframes, chaque dataframe est une espèce
doub<-lapply(resultats, duplicated) # Vérifier si les données sont des doublons dans chacun des dataframes (c'est ce qu'on veut, que les infos soient pareilles)
    #normal que le premier est FALSE puisque c'est le premier doublon (les autres sont des doubles du premier, le premier est un non doublon)

#appliquer la fonction pour compter le nombre de faux (s'il y en a plus qu'un, il y a une erreur)
source("fonctions/compter_faux.R")
erre<-lapply(doub, compter_faux) #applique la fonction dans la liste
    #erreur dans Anatidae, Dryobates pubescens, Passeriformes et Vireo

#correction des erreurs
source("fonctions/correction_erreurs.R")

#Vérifier le format de l'heure d'observation
source("fonctions/format_heure.R")
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
source("fonctions/creation_tables.R")

library(RSQLite)

conn<-dbConnect(SQLite(), dbname="accousitque.db")

#Creation de la table qui contient les informations relatives aux sites d'echantillonage
dbSendQuery(conn, "DROP TABLE site;")
source("fonctions/db_site.R")

#Creation de la table qui contient les informations relatives a la taxonomie des especes
dbSendQuery(conn, "DROP TABLE taxo;")
source("fonctions/db_taxo.R")

#Creation de la table qui contient les informations relatives a l'effort d'echantillonnage
dbSendQuery(conn, "DROP TABLE effort_e;")
source("fonctions/db_effort_e.R")

#Creation de la table qui contient les informations relatives aux observations
dbSendQuery(conn, "DROP TABLE obs;")
source("fonctions/db_obs.R")


dbWriteTable(conn, append = TRUE, name = "site", value = endroit_u, row.names = FALSE)
dbWriteTable(conn, append = TRUE, name = "taxo", value = taxo_u, row.names = FALSE)
dbWriteTable(conn, append = TRUE, name = "obs", value = Oiseau, row.names = FALSE)
dbWriteTable(conn, append = TRUE, name = "effort_e", value = effort_u, row.names = FALSE)

#Test pour s'assurer que les donn�es sont inject�es dans la base de donn�es
niveau_espece<- '
  SELECT date_obs
    FROM obs
;'

espece_connue<-dbGetQuery(conn, niveau_espece)

head(espece_connue)

dbDisconnect(conn)
