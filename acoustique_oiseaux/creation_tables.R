
# Creation de la premiÃ¨re table (Endroit) #
Endroit<-data.frame(
  site_id = df$site_id, 
  lat = df$lat,
  projection = df$projection
)

#On met les doublons pour créer des valeurs uniques
endroit_u<-Endroit %>%
  select(site_id, lat, projection) %>%
  distinct(site_id, .keep_all = TRUE)
head(endroit_u)


# Creation de la deuxiÃ¨me table (Oiseau) #
Oiseau<-data.frame(
  presence = df$presence,
  id_obs = df$ID_obs,
  time_obs = df$time_obs,
  valid_scientific_name = df$valid_scientific_name
)


# CrÃ©ation de la troisiÃ¨me table (Identite_taxo) #
Identite_taxo<-data.frame(
  valid_scientific_name = df$valid_scientific_name,
  rank = df$rank,
  vernacular_en = df$vernacular_en,
  vernacular_fr = df$vernacular_fr,
  kingdom = df$kingdom,
  phylum = df$phylum,
  class = df$class,
  ordre = df$ordre,
  family = df$family,
  genus = df$genus,
  species = df$species
)

effort<-data.frame(
  site_id = df$site_id,
  time_start = df$time_start,
  time_finish = df$time_finish,
  date_obs=df$date_obs
)


#On met les doublons pour créer des vaaleurs uniques
taxo_u<-Identite_taxo %>%
  distinct(valid_scientific_name, .keep_all = TRUE)
#elimine doublons effort
effort_u<-effort %>%
  select(site_id, time_start, time_finish, date_obs) %>%
  distinct(site_id, time_start, time_finish, date_obs ,.keep_all = TRUE)
