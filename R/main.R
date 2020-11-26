#' Create a div for main content.

#' @name main
#' @param ... html attributes and inner html
#' @param class  [character]  Must have an exact length of 1.  Defaults to 'col-md-9 ml-sm-auto col-lg-10 p-0 m-0'
#' @return \code{main}: html
#' @export
main <- function(..., class = "col-md-9 ml-sm-auto col-lg-10 p-0 m-0") {
    # Create a div for main content
    assert_character(class, len = 1)
    tags$main(role = "main", class = class, ...)
    # Returns: html
}
