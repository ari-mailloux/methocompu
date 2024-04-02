#fonction pour changer les NULL en NA
NULL_NA<- function(don) {
  don[don=="NULL"]<-NA
  return(don)
}

