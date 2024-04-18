#Fonction pour changer le nom de la colonne "variable" vers "presences".
#L'argument db_pres est la base de donnees a corriger.
#variable désigne le nom de colonne d'origine.
#presences désigne le nom pour lequel il faut changer le nom de cette colonne.

rename_variable <- function(db_pres, variable, presences) {
  names(db_pres)[names(db_pres) == "variable"] <-"presences"
  return(db_pres)
}