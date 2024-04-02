creer_site <- 
  "CREATE TABLE site (
    site_id     INTEGER,
    lat         VARCHAR(20),
    projection  VARCHAR(200),
    PRIMARY KEY (site_id)
  );"
dbSendQuery(conn, creer_site )
