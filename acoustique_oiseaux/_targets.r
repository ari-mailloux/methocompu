library(targets)
tar_option_set(packages = c("rmarkdown", "dplyr", "RSQLite"))

list(
  tar_target(
    name = fichiers,
    command = list.files(pattern = "\\.csv$")
  ),
  tar_target(
    dat,
    lapply(fichiers, read.csv)
  ),
  tar_target(
    donnees_combin,
    do.call(rbind, dat)
  ),
  tar_target(
    null_en_na,
    null_vers_na(donnees_combin)
  )
)
