#' Create a dropdown group.

#' @name dropdown_group
#' @param ...
#' @return \code{dropdown_group}: \code{[html]}
#' @export
dropdown_group <- function(...) {
    # Create a dropdown group
    div(...) %>% tagAppendAttributes(class = "dropdown-group")
    # Returns: \code{[html]}
}
