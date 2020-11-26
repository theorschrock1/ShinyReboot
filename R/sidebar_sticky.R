#' Create a sticky sidebar.
#'
#' Should be used inside sidebar_left/right.

#' @name sidebar_sticky
#' @param ... html attributes and inner html
#' @return \code{sidebar_sticky}: html
#' @export
sidebar_sticky <- function(...) {
    # Create a sticky sidebar. Should be used inside sidebar_left/right.
    dots <- list(...)
    dots$class = paste("sidebar-sticky overflow-hidden", dots$class)
    expr_eval(div(!!!dots))
    # Returns: html
}
