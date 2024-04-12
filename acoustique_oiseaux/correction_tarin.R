#nom vernaculaire francais des Carduelis pinus
#erreur: changer le nom vernaculaire franÃ§ais Tarin pour Tarin des pins

for (i in 1:nrow(df)) {
  if (!is.na(df$valid_scientific_name[i]) && df$valid_scientific_name[i] == "Carduelis pinus") {
    df$vernacular_fr[i] <- "Tarin des pins"
  }
}
