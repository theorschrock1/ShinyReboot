#' Generate a material icon.

#' @name icon_mdi
#' @param name  [character]  Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @param ... additional html attributes.
#' @return \code{icon_mdi}: [htmlTag(span)]
#' @examples

#'  icon_mdi('undo')

#' @export
icon_mdi <- function(name, class = NULL,...) {
    # Generate a materical icon
    if (missing(name))
        return()
    assert_character(name, len = 1)
    assert_character(class, len = 1,null.ok = TRUE)
    out=tags$span(class = glue("mdi mdi-{name}",...))
    out=tagAppendAttributes(out,class=class)
    out %>%
        attachDependencies(html_dependency_material_icons())
    # Returns: [htmlTag(span)]
}
