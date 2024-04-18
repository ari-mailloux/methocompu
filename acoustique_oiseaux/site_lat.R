#Fonction pour verifier que chaque site a toujours la meme valeur de latitude.
#L'argument latibas designe la base de donnees.
#colonne_lat designe la colonne avec les valeurs de latitude.
#colonne_site_id designe la colonne avec le numero du site.

verifier_latitude <- function(latibas, colonne_lat, colonne_site_id) {
  resultats <- aggregate(latibas[[colonne_lat]] ~ latibas[[colonne_site_id]], latibas, function(x) length(unique(x)) == 1)
  return(resultats)
}
