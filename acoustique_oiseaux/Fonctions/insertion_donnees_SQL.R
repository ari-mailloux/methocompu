#Fonction pour injecter les donnees 
#L'argument conn est la connexion au SQL.
#tables est le nom de la liste contenant les differentes tables de donnees a injecter.
inserer_donnees <- function(conn, tables) {
  dbWriteTable(conn, append = TRUE, name = "site", value = tables$site, row.names = FALSE)
  dbWriteTable(conn, append = TRUE, name = "taxo", value = tables$taxo, row.names = FALSE)
  dbWriteTable(conn, append = TRUE, name = "obs", value = tables$obs, row.names = FALSE)
  dbWriteTable(conn, append = TRUE, name = "effort_e", value = tables$effort_e, row.names = FALSE)
}