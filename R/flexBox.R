#' Create a BS4 flex box.

#' @name flexBox
#' @param ... html attributes and inner html
#' @return \code{flexBox}: HTML
#' @export
flexBox <- function(...) {
    # Create a BS4 flex box
    dots <- list(...)
    dots$class = paste("d-flex", dots$class)
    expr_eval(div(!!!dots))
    # Returns: HTML
}
