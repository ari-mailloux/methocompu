obs_par_cana <- function(requete2) {
  connexion <- dbConnect(SQLite(), dbname = "acoustique.db")
  requete2 <- "
    SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
    FROM obs
    WHERE valid_scientific_name = 'Cardellina canadensis'
    GROUP BY STRFTIME('%H:00:00', time_obs)
    ORDER BY heure_formattee;"
  paru <- dbGetQuery(connexion, requete2)
  
  dbDisconnect(connexion)
  return(paru)
}
