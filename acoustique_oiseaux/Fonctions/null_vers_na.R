#Fonction pour changer les NULL en NA.
#L'argument don designe la base de donnees a corriger.

null_vers_na<- function(don) {
  don[don=="NULL"]<-NA
  return(don)
}

