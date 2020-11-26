#' Generate a materical icon.

#' @name icon_mdi
#' @param name  [character]  Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @return \code{icon_mdi}: [htmlTag(span)]
#' @examples

#'  icon_mdi('undo')

#' @export
icon_mdi <- function(name, class = "") {
    # Generate a materical icon
    if (missing(name))
        return()
    assert_character(name, len = 1)
    assert_character(class, len = 1)
    tagList(tags$span(class = glue("mdi mdi-{name} {class}")),mdi_depends())
    # Returns: [htmlTag(span)]
}
