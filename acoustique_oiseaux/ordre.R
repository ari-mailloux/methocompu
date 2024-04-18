#Le nom de colonne "order" cause des problemes avec le logiciel.
#Donc, voici une fonction pour changer le nom de la colonne a "ordre".
#L'argument or designe la base de donnees a corriger, order désigne le nom initial
#de la colonne et ordre désigne le nom vers lequel on doit le changer.

rename_col <- function(or, order, ordre) {
  names(or)[names(or) == "order"] <- "ordre"
  return(or)
}
