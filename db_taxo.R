creer_taxo <- 
  "CREATE TABLE taxo (
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
dbSendQuery(conn, creer_taxo)
