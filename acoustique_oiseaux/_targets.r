library(targets)
tar_option_set(packages = c("rmarkdown", "dplyr", "RSQLite"))

source("null_vers_na.R")
source("convertir_date.R")
source("bool.R")
source("ajout_col.R")
source("ajout_proj.R")
source("virgules_latitude.R")
source("site_lat.R")
source("lat_qc.R")

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
  ),
  tar_target(
    id_obs,
    ajouter_ID_obs(null_en_na)
  ),
  tar_target(
    projection,
    ajouter_projection(id_obs)
  ),
  tar_target(
    data_frame,
    cbind(projection, date, booleen_variable)
  ),
  tar_target(
    verif_virg,
    verifier_virgules(data_frame, "lat")
  ),
  tar_target(
    verif_lat,
    verifier_latitude(data_frame, "site_id", "lat")
  ),
  tar_target(
    lat_queb,
    verifier_qc(data_frame, "lat")
  )
)


