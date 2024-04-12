rename_variable <- function(db_pres, variable, presences) {
  names(db_pres)[names(db_pres) == "variable"] <-"presences"
  return(db_pres)
}