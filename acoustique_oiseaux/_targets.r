library(targets)
tar_option_set(packages = c("rmarkdown", "dplyr", "RSQLite"))

source("null_vers_na.R")
source("convertir_date.R")
source("bool.R")

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
  ),
  tar_target(
    date,
    sapply(null_en_na$date_obs, convertir_date)
  ),
  tar_target(
    booleen_variable,
    sapply(null_en_na$variable, presence)
  )
)

