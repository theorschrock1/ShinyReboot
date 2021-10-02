#' Create a left sidebar.

#' @name sidebar_left
#' @param ...  html attributes and inner html
#' @param id  [character]  Must have an exact length of 1.
#' @return \code{sidebar_left}: html
#' @export
sidebar_left <- function(..., id) {
    # Create a left sidebar
    assert_character(id, len = 1)
    dots <- list(...)
    nav_class = paste("col-md-3 col-lg-2 sidebar", dots$class)
    dots$class = NULL
    expr_eval(tags$nav(id = !!id, class = !!nav_class, !!!dots))
    # Returns: html
}
