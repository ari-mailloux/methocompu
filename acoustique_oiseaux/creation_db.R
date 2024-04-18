#Fonction pour creer la base de donnees SQL et injecter les donnees
#L'argument db_name designe la base de donnees
#endroit_u designe la table contenant les donnees a injecter dans la table SQL site
#taxo_u designe la table contenant les donnees a injecter dans la table SQL taxo
#oiseaux designe la table contenant les donnees a injecter dans la table SQL obs
#effort_u designe la table contenant les donnees a injecter dans la table SQL effort_e

creer_db <- function(db_name, endroit_u, taxo_u, oiseaux, effort_u) {
  # Créer la connexion à la base de données
  connexion <- dbConnect(SQLite(), dbname = db_name)
  
  # Réinitialiser les tables
  dbSendQuery(connexion, "DROP TABLE IF EXISTS site;")
  dbSendQuery(connexion, "DROP TABLE IF EXISTS taxo;")
  dbSendQuery(connexion, "DROP TABLE IF EXISTS obs;")
  dbSendQuery(connexion, "DROP TABLE IF EXISTS effort_e;")
  
  # Définir les requêtes SQL pour créer les tables
  creer_effort_e <- 
    "CREATE TABLE IF NOT EXISTS effort_e (
      site_id                 INTEGER,
      time_start              VARCHAR(50),
      time_finish             VARCHAR(50),
      date_obs                DATE,
      PRIMARY KEY (site_id, time_start, time_finish, date_obs),
      FOREIGN KEY (site_id) REFERENCES site(site_id),
      FOREIGN KEY (date_obs) REFERENCES obs(date_obs)
    );"
  
  creer_obs <- 
    "CREATE TABLE IF NOT EXISTS obs (
      presence                BOOLEAN,
      date_obs                DATE,
      id_obs                  INTEGER PRIMARY KEY AUTOINCREMENT,
      site_id                 INTEGER,
      time_obs                CHAR,
      valid_scientific_name   VARCHAR(50),
      rank                    VARCHAR(50),
      FOREIGN KEY (site_id) REFERENCES site(site_id),
      FOREIGN KEY (valid_scientific_name) REFERENCES taxo(valid_scientific_name),
      FOREIGN KEY (rank) REFERENCES taxo(rank)
    );"
  
  creer_site <- 
    "CREATE TABLE IF NOT EXISTS site (
      site_id     INTEGER,
      lat         VARCHAR(20),
      projection  VARCHAR(200),
      PRIMARY KEY (site_id)
    );"
  
  creer_taxo <- 
    "CREATE TABLE IF NOT EXISTS taxo (
      valid_scientific_name   VARCHAR(50),
      rank                    VARCHAR(50),
      vernacular_en           VARCHAR(50),
      vernacular_fr           VARCHAR(50),
      kingdom                 VARCHAR(50),
      phylum                  VARCHAR(50),
      class                   VARCHAR(50),
      ordre                   VARCHAR(50),
      family                  VARCHAR(50),
      genus                   VARCHAR(50),
      species                 VARCHAR(50),
      PRIMARY KEY (valid_scientific_name)
    );"
  
  # Envoyer les requêtes SQL pour créer les tables
  dbSendQuery(connexion, creer_effort_e)
  dbSendQuery(connexion, creer_obs)
  dbSendQuery(connexion, creer_site)
  dbSendQuery(connexion, creer_taxo)
  
  # Insérer les données dans les tables
  dbWriteTable(connexion, append = TRUE, name = "site", value = endroit_u, row.names = FALSE)
  dbWriteTable(connexion, append = TRUE, name = "taxo", value = taxo_u, row.names = FALSE)
  dbWriteTable(connexion, append = TRUE, name = "obs", value = oiseaux, row.names = FALSE)
  dbWriteTable(connexion, append = TRUE, name = "effort_e", value = effort_u, row.names = FALSE)
  
  # Appel à obs_par_heure
  observations_par_heure <- obs_par_heure(connexion, obs)
  
  # Retourner une liste contenant les données insérées
  listedb <- list(site = endroit_u, taxo = taxo_u, obs = oiseaux, effort_e = effort_u, observations_par_heure = observations_par_heure)
  return(listedb)
  str(observations_par_heure)
}
