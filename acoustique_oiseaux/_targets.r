library(targets)
tar_option_set(packages = c("rmarkdown", "dplyr", "RSQLite"))

list(
  tar_target(
    fichiers,
    list.files(pattern = "\\.csv$")
  )
)
