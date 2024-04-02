#fonction de vérification du format des heures
verifier_format_heure<-function(heure){
  grepl("^([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$",heure)
}
