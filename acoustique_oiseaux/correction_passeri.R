pas<-subset(df, valid_scientific_name == "Passeriformes")#observation des donnÃ©es pour trouver oÃ¹ est la diffÃ©rence
#erreurs: plusieurs lignes comportait des NA Ã  la place des noms vernaculaires franÃ§ais et anglais
for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Passeriformes") { #recherche du nom sans prendre en compte les NA
    df$vernacular_en[i] <- "Perching birds"
    df$vernacular_fr[i] <- "Passereaux"
  }
}