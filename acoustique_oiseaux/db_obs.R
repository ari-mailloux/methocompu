creer_obs <- 
  "CREATE TABLE obs (
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
dbSendQuery(conn, creer_obs )