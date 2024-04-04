#fonction pour changer les NULL en NA
null_vers_na<- function(don) {
  don[don=="NULL"]<-NA
  return(don)
}

