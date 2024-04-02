creer_effort_e <- 
  "CREATE TABLE effort_e (
    site_id                 INTEGER,
    time_start              VARCHAR(50),
    time_finish             VARCHAR(50),
    date_obs                DATE,
    PRIMARY KEY (site_id, time_start, time_finish, date_obs),
    FOREIGN KEY (site_id) REFERENCES site(site_id),
    FOREIGN KEY (date_obs) REFERENCES obs(date_obs)
  );"
dbSendQuery(conn, creer_effort_e)