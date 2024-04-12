#nom vernaculaire anglais des troglodytes des forÃªts
#erreur: changer le nom vernaculaire anglais de "Animals" Ã  "Winter wren"

for (i in 1:nrow(df)) {
  if (!is.na(df$vernacular_fr[i]) && df$vernacular_fr[i] == "Troglodyte des forÃªts") {
    df$vernacular_en[i] <- "Winter wren"
  }
}