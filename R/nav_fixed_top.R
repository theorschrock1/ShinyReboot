#' Create a BS4 fixed top navbar.

#' @name nav_fixed_top
#' @param ... html attributes and inner html
#' @return \code{nav_fixed_top}: HTML
#' @export
nav_fixed_top <- function(...) {
    # Create a BS4 fixed top navbar
    dots <- list(...)
    dots$class = paste("navbar fixed-top flex-md-nowrap", dots$class)
    expr_eval(tags$nav(!!!dots))
    # Returns: HTML
}
