#' Use a feather icon.

#' @name feather_icon
#' @param name  [character]  Name of Icon. See https://feathericons.com/. Must have an exact length of 1.
#' @param ...
#' @return \code{feather_icon}: html
#' @export
feather_icon <- function(name, ...) {
    # Use a feather icon
    assert_character(name, len = 1)
    tags$span(`data-feather` = name, ...)
    # Returns: html
}
