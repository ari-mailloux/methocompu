library(targets)
library(tarchetypes)
tar_option_set(packages = c("rmarkdown", "dplyr", "RSQLite","knitr"))

source("Fonctions/null_vers_na.R")
source("Fonctions/convertir_date.R")
source("Fonctions/bool.R")
source("Fonctions/ajout_col.R")
source("Fonctions/ajout_proj.R")
source("Fonctions/virgules_latitude.R")
source("Fonctions/site_lat.R")
source("Fonctions/lat_qc.R")
source("Fonctions/var_pres.R")
source("Fonctions/regroup.R")
source("Fonctions/compter_faux.R")
source("Fonctions/correction_anatidae.R")
source("Fonctions/correction_dryobates.R")
source("Fonctions/correction_passeri.R")
source("Fonctions/correction_tarin.R")
source("Fonctions/correction_troglo.R")
source("Fonctions/correction_vireo.R")
source("Fonctions/format_heure.R")
source("Fonctions/erreur_heure.R")
source("Fonctions/NA_heure.R")
source("Fonctions/ordre.R")
source("Fonctions/creation_tables.R")
source("Fonctions/unicite_tables.R")
source("Fonctions/creation_db.R")
source("Fonctions/obs_par_heure.R")
source("Fonctions/paru_canada.R")
source("Fonctions/diversite.R")

list(
  tar_target(
    name = fichiers,
    command = list.files(pattern = "\\.csv$", path = "acoustique_oiseaux")
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
    pres,
    rename_variable(null_en_na)
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
    cbind(projection, date, booleen_variable, pres)
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
  ),
  tar_target(
    combinaison,
    data.frame(data_frame,"valid_scientific_name","vernacular_en", "vernacular_fr", "species", "kingdom", "phylum", "family", "genus", "rank")
  ),
  tar_target(
  groupe_par_espece,
  regroup(combinaison)
  ),
  tar_target(
    doublons,
    lapply(groupe_par_espece, duplicated)
  ),
  tar_target(
    comptage_faux,
    compter_faux(doublons)
  ),
  tar_target(
    verif_format_heure,
    sapply(data_frame$time_obs, verifier_format_heure)
  ),
  tar_target(
    faux_heure,
    grep(FALSE, verif_format_heure)
  ),
  tar_target(
    nb_erreur,
    check_mistakes(faux_heure)
  ),
  tar_target(
    erreur_na,
    check_NA_heure(data_frame)
  ),
  tar_target(
    anatidae,
    replace_anatidae(data_frame)
  ),
  tar_target(
    dryobates,
    replace_dry(anatidae)
  ),
  tar_target(
    passeriformes,
    correction_passeriformes(dryobates)
  ),
  tar_target(
    tarins,
    replace_car(passeriformes)
  ),
  tar_target(
    troglodytes,
    replace_tro(tarins)
  ),
  tar_target(
    corr_finales,
    replace_vir(troglodytes)
  ),
  tar_target(
    ordre,
    sapply(corr_finales$order, rename_col)
  ),
  tar_target(
    bd_complet,
    cbind(ordre, troglodytes)
    ),
  tar_target(
    creation_tables,
    creer_tables(bd_complet)
  ),
  tar_target(
    unicite,
    traiter_data(creation_tables$table1, creation_tables$table4, creation_tables$table3)
    ),
  tar_target(
    bd_SQL,
    creer_db("acoustique.db", unicite$endroit_u, unicite$taxo_u,creation_tables$table2, unicite$effort_u)
  ),
  tar_target(
    obs_heure,
    obs_par_heure(bd_SQL$obs)
  ),
  tar_target(
    paruline_canada,
    obs_par_cana(bd_SQL$obs)
  ),
  tar_target(
    diversite_par_heure,
    diversite_heure(bd_SQL$obs)
  ),
  tar_render(
    name = rapport,
    path = ("Rapport/Rapport.Rmd")
  )
)


