#' Create a BS4 navbar title.
#'
#' For use inside a fixed top nav

#' @name nav_brand
#' @param ... html attributes and inner html
#' @return \code{nav_brand}: HTML
#' @export
nav_brand <- function(...) {
    # Create a BS4 navbar title.  For use inside a fixed top nav
    dots <- list(...)
    dots$class = paste("navbar-brand col-md-3 col-lg-2", dots$class)
    expr_eval(tags$a(!!!dots))
    # Returns: HTML
}
