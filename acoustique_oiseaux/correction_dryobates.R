dry<-subset(df, valid_scientific_name == "Dryobates pubescens")#observation des donnÃ©es pour trouver oÃ¹ est la diffÃ©rence
#erreurs: plusieurs lignes comportait des NA Ã  la place des noms vernaculaires franÃ§ais et anglais
for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Dryobates pubescens") { #recherche du nom sans prendre en compte les NA
    df$vernacular_en[i] <- "Downy woodpecker"
    df$vernacular_fr[i] <- "Pic mineur"
  }
}