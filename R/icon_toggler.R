#' Create an icon toggler.

#' @name icon_toggler
#' @param inputId  \code{[string]}
#' @param value  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param icon_false  \code{[string]}
#' @param icon_true  \code{[string]}
#' @param ...
#' @return \code{icon_toggler}: \code{[html]}
#' @examples

#'  icon_toggler(inputId = 'myid', value = FALSE, icon_false = 'folder-outline',
#'  icon_true = 'folder-open-outline')
#'  icon_toggler(inputId = 'myid', value = TRUE, icon_false = 'folder-outline',
#'  icon_true = 'folder-open-outline', class = 'icon-sm')
#' @export
icon_toggler <- function(inputId, value = FALSE, icon_false, icon_true, ...) {
    # Create an icon toggler
    assert_string(inputId)
    assert_logical(value, len = 1)
    assert_string(icon_false)
    assert_string(icon_true)
    tag = icon_mdi(name = icon_false, ...)
    class <- "icon-toggler"
    if (value) 
        class <- paste("icon-toggler", icon_true)
    class(tag)
    out <- tagAppendAttributes(tag, id = inputId, class = class, `data-value` = js_logical(value), 
        `data-icon-on` = icon_true)
    out %>% attachDependencies(html_dependency_icon_toggler())
    # Returns: \code{[html]}
}
