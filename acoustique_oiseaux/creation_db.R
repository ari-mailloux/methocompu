dbSQL<- function(dfSQL) {
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
  dbSendQuery(dfSQL, creer_effort_e)

#Creation de la base de donnée "Observation"
creer_obs <- 
  "CREATE TABLE IF NOT EXISTS obs (
    presence                BOLEAN,
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
dbSendQuery(dfSQL, creer_obs )

#Creation de la base de donnée "Site"
creer_site <- 
  "CREATE TABLE IF NOT EXISTS site (
    site_id     INTEGER,
    lat         VARCHAR(20),
    projection  VARCHAR(200),
    PRIMARY KEY (site_id)
  );"
dbSendQuery(dfSQL, creer_site )

#Creation de la base de donnée "Identité taxonomique"
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
dbSendQuery(dfSQL, creer_taxo)
listedb<-list(site = endroit_u, taxo = taxo_u, obs = oiseaux, effort_e = effort_u)
return(listedb)
}
