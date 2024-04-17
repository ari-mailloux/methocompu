inserer_donnees <- function(conn, tables) {
  dbWriteTable(conn, append = TRUE, name = "site", value = tables$site, row.names = FALSE)
  dbWriteTable(conn, append = TRUE, name = "taxo", value = tables$taxo, row.names = FALSE)
  dbWriteTable(conn, append = TRUE, name = "obs", value = tables$obs, row.names = FALSE)
  dbWriteTable(conn, append = TRUE, name = "effort_e", value = tables$effort_e, row.names = FALSE)
}