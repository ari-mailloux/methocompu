#Requête SQL qui permet de dire le nombre d'observation par heure
#Note: Il y a rien entre 13h et 19h. Aucun échantillonnage dans ces heures?
par_heure<- "
 SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
  FROM obs
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"

#Tableau avec le nombre d'observations selon l'heure
heure<-dbGetQuery(conn, par_heure)

#Requête SQL qui dit le nombre d'observation de la paruline du Canada selon l'heure
paruline_canada<-"
  SELECT valid_scientific_name, STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(*) AS nb_obs
  FROM obs
  WHERE valid_scientific_name= 'Cardellina canadensis'
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"

#Tableau avec le nombre d'observations de parulines du Canada selon l'heure
obs_par_cana<-dbGetQuery(conn, paruline_canada)

#Requête SQL qui dit le nombre d'espèces observées à chaque heure
diversite<- "
 SELECT STRFTIME('%H:00:00', time_obs) AS heure_formattee, COUNT(DISTINCT valid_scientific_name) AS nb_valid_scientific_names
  FROM obs
  WHERE rank = 'species'
  GROUP BY STRFTIME('%H:00:00', time_obs)
  ORDER BY heure_formattee;"

#Tableau avec le nombre d'espèces observées par heure
diversite_heure<-dbGetQuery(conn, diversite)