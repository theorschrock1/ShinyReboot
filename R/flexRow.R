#' Create a BS4 flex row.

#' @name flexRow
#' @param ... html attributes and inner html
#' @return \code{flexRow}: HTML
#' @export
flexRow <- function(...) {
    # Create a BS4 flex row
    dots <- list(...)
    dots$class = paste("flex-row", dots$class)
    expr_eval(flexBox(!!!dots))
    # Returns: HTML
}
