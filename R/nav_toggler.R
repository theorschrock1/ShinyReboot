#' Create a navbar toggler button.

#' @name nav_toggler
#' @param ...
#' @param class  [character]  Must have an exact length of 1.  Defaults to NULL
#' @param data_target  [character] the id of the targat nav. Must start with "#" and Must have an exact length of 1.
#' @param expanded  [logical]  Must have an exact length of 1.  Defaults to FALSE
#' @param icon  [character]  Must have an exact length of 1.  Defaults to 'navbar-toggler-icon'
#' @return \code{nav_toggler}: NULL
#' @export
nav_toggler <- function(..., class = NULL, data_target, expanded = FALSE, icon = "navbar-toggler-icon") {
    # Create a navbar toggler button
    assert_character(class, len = 1)
    assert_character(data_target, len = 1)
    assert_logical(expanded, len = 1)
    assert_character(icon, len = 1)
    if (!grepl(start_with("#"), data_target))
        g_stop("data_target '{data_target}' must begin with a #. Use '#{data_target}")
    class = paste("navbar-toggler position-absolute", class)
    tags$button(class = class, type = "button", `data-toggle` = "collapse", `data-target` = data_target,
        `aria-controls` = str_remove(data_target, start_with("#")), `aria-expanded` = js_logical(expanded),
        `aria-label` = "Toggle navigation", tags$span(class = icon), ...)
    # Returns: NULL
}
