ana<-subset(df, valid_scientific_name == "Anatidae") #observation des donnÃ©es pour trouver oÃ¹ est la diffÃ©rence
#erreurs: plusieurs lignes comportait des NA Ã  la place des noms vernaculaires franÃ§ais et anglais
for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Anatidae") { #recherche du nom Anatidae sans prendre en compte les NA
    df$vernacular_en[i] <- "Ducks"
    df$vernacular_fr[i] <- "Canards"
  }
}

dry<-subset(df, valid_scientific_name == "Dryobates pubescens")#observation des donnÃ©es pour trouver oÃ¹ est la diffÃ©rence
#erreurs: plusieurs lignes comportait des NA Ã  la place des noms vernaculaires franÃ§ais et anglais
for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Dryobates pubescens") { #recherche du nom sans prendre en compte les NA
    df$vernacular_en[i] <- "Downy woodpecker"
    df$vernacular_fr[i] <- "Pic mineur"
  }
}

pas<-subset(df, valid_scientific_name == "Passeriformes")#observation des donnÃ©es pour trouver oÃ¹ est la diffÃ©rence
#erreurs: plusieurs lignes comportait des NA Ã  la place des noms vernaculaires franÃ§ais et anglais
for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Passeriformes") { #recherche du nom sans prendre en compte les NA
    df$vernacular_en[i] <- "Perching birds"
    df$vernacular_fr[i] <- "Passereaux"
  }
}

vir<-subset(df, valid_scientific_name == "Vireo")#observation des donnÃ©es pour trouver oÃ¹ est la diffÃ©rence
#erreurs: plusieurs lignes comportait des NA Ã  la place des noms vernaculaires franÃ§ais et anglais
for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Vireo") { #recherche du nom sans prendre en compte les NA
    df$vernacular_en[i] <- "Vireos"
    df$vernacular_fr[i] <- "VirÃ©o"
  }
}

#nom vernaculaire anglais des troglodytes des forÃªts
#erreur: changer le nom vernaculaire anglais de "Animals" Ã  "Winter wren"

for (i in 1:nrow(df)) {
  if (!is.na(df$vernacular_fr[i]) && df$vernacular_fr[i] == "Troglodyte des forÃªts") {
    df$vernacular_en[i] <- "Winter wren"
  }
}

#nom vernaculaire francais des Carduelis pinus
#erreur: changer le nom vernaculaire franÃ§ais Tarin pour Tarin des pins

for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Carduelis pinus") {
    df$vernacular_fr[i] <- "Tarin des pins"
  }
}
