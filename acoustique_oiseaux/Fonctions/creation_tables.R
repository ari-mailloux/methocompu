#Fonction pour separer la base de donnees en tables
#L'argument tables designe la base de donnees

creer_tables <- function(tables) {
  
  # Création de la table Endroits
  endroits <- data.frame(site_id = tables$site_id, lat = tables$lat, projection = tables$projection)
  
  # Création de la table Oiseaux
  oiseaux <- data.frame( presence = tables$presence,
                         id_obs = tables$ID_obs,
                         time_obs = tables$time_obs,
                         valid_scientific_name = tables$valid_scientific_name,
                         rank = tables$rank,
                         date_obs = tables$date_obs
  )
 
  # Création de la table Taxonomie
  taxonomie<- data.frame(
    valid_scientific_name = tables$valid_scientific_name,
    rank = tables$rank,
    vernacular_en = tables$vernacular_en,
    vernacular_fr = tables$vernacular_fr,
    kingdom = tables$kingdom,
    phylum = tables$phylum,
    class = tables$class,
    ordre = tables$ordre,
    family = tables$family,
    genus = tables$genus,
    species = tables$species
  )
  
  # Création de la table Effort
  effort<-data.frame(
    site_id = tables$site_id,
    time_start = tables$time_start,
    time_finish = tables$time_finish,
    date_obs=tables$date_obs
  )
  liste<-list(table1 = endroits, table2 = oiseaux, table3 = taxonomie, table4 = effort)
  return(liste)
}


