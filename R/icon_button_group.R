#' Create an icon button group.

#' @name icon_button_group
#' @param inputId  [character]
#' @param icon_name  [character]  Must have an exact length of length.  Must have an exact length of inputId.
#' @param tooltip  [character]  Must have an exact length of length.  Must have an exact length of inputId.
#' @param class  [character]  Defaults to ''
#' @param tooltip_placement  [character]  Must have an exact length of 1.  Defaults to 'top'
#' @return \code{icon_button_group}: [HTML]
#' @examples

#'  icon_button_group(inputId = c('undo', 'redo', 'save'), icon_name = c('undo',

#'  'redo', 'content-save-outline'), tooltip = c('Undo',

#'  'Redo', 'Save'))

#' @export
icon_button_group <- function(inputId, icon_name, tooltip, class = "", tooltip_placement = "top") {
    # Create an icon button group
    assert_character(inputId)
    assert_character(icon_name, len = length(inputId))
    assert_character(tooltip, len = length(inputId))
    assert_character(class)
    assert_character(tooltip_placement, len = 1)
    inner = expr_glue(tags$button(id = "{inputId}", role = "button", `data-toggle` = "tooltip", title = "{tooltip}",
        class = "btn btn-sm menu-item ao-action-button", tags$span(class = "mdi mdi-{icon_name} menu-icons {class}"))) %>%
        lapply(eval)
   outTag= div(class = "btn-group-toggle",inner)
   attachDependencies( outTag, html_dependency_material_icons())
    # Returns: [HTML]
}
