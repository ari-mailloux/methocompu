diversite_heure <- function(requete3) {
  connexion <- dbConnect(SQLite(), dbname = "acoustique.db")
  requete3 <- "
    SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(DISTINCT valid_scientific_name) AS nb_valid_scientific_names
    FROM obs
    WHERE rank = 'species'
    GROUP BY STRFTIME('%H:00:00', time_obs)
    ORDER BY heure_formattee;"
  diversite <- dbGetQuery(connexion, requete3)
  dbDisconnect(connexion)
  return(diversite)
}
