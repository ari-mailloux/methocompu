library(targets)
tar_option_set(packages = c("rmarkdown", "dplyr", "RSQLite"))

list(
  tar_target(
    name = fichiers,
    command = list.files(pattern = "\\.csv$")
  ),
  tar_target(
    name = dat,
    command = lapply(fichiers, read.csv)
  ),
  tar_target(
    name = donnees_combinees,
    command = do.call(rbind, dat)
  ),
  tar_target(
    name = pas_NA,
    command = NULL_NA
  )
)
