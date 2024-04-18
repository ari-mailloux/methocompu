#Fonction pour transformer la variable présence\absence en format booléen.
#L'argument bool désigne la colonne qui doit etre transformée.
presence<-function(bool){
  return(bool=="présence")
}
