traiter_data <- function(unicite_end, unicite_ef, unicite_tax) {
  #traiter_data <- function(end, ef, taxo) {
  endroit_u <- unicite_end %>%
    select(site_id, lat, projection) %>%
    distinct(site_id, .keep_all = TRUE)
  
  effort_u <- unicite_ef %>%
    select(site_id, time_start, time_finish, date_obs) %>%
    distinct(site_id, time_start, time_finish, date_obs, .keep_all = TRUE)
   
   taxo_u <- unicite_tax %>%
    select(valid_scientific_name) %>%
    distinct(valid_scientific_name, .keep_all = TRUE)
  
  #Imprimer les tables
  #cat("Table Endroit unique :\n")
  print(endroit_u)
  
  #cat("\nTable Effort unique :\n")
  #print(effort_u)
  
  #cat("\nTable Identite_taxo unique :\n")
  #print(taxo_u)
  liste2<-list(endroit_u = endroit_u, effort_u = effort_u, taxo_u = taxo_u)
  return(liste2)
}
