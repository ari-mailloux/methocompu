rename_col <- function(or, order, ordre) {
  names(or)[names(or) == "order"] <- "ordre"
  return(or)
}
