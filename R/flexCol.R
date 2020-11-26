#' Create a BS4 flex column.

#' @name flexCol
#' @param ... html attributes and inner html
#' @return \code{flexCol}: HTML
#' @export
flexCol <- function(...) {
    # Create a BS4 flex column
    dots <- list(...)
    dots$class = paste("flex-column", dots$class)
    expr_eval(flexBox(!!!dots))
    # Returns: HTML
}
