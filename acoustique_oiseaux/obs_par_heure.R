#Fonction pour compter combien d'observations ont été faites par heure, toutes especes confondues.
#L'argument connexion est la connexion au SQL.
#obs désigne la table avec les donnees sur les observations.


obs_par_heure <- function(requete) {
  connexion <- dbConnect(SQLite(), dbname = "acoustique.db")
  requete <- "
    SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
    FROM obs
    GROUP BY STRFTIME('%H:00:00', time_obs)
    ORDER BY heure_formattee;"
  heure <- dbGetQuery(connexion, requete)
  dbDisconnect(connexion)
  return(heure)
  print(heure)
}
