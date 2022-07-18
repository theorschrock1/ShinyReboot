#' Create an icon button group.

#' @name icon_radio_group
#' @param inputId  [character]  Must have an exact length of 1.
#' @param options
#' @param icon_name  [character]
#' @param tooltip  [character]  Must have an exact length of length.  Must have an exact length of icon_name.
#' @param class  [character]  Defaults to ''
#' @param tooltip_placement  [character]  Must have an exact length of 1.  Defaults to 'top'
#' @return \code{icon_radio_group}: [HTML]
#' @examples

#'  icon_radio_group(inputId = 'sort_options', options = c('sort_remove',
#'  'sort_ascending', 'sort_descending'), icon_name = c('sort-variant-remove',
#'  'sort-ascending', 'sort-descending'), tooltip = c('Clear sort',
#'  'Sort ascending', 'Sort descending'))

#' @export
icon_radio_group_bs4 <- function(inputId, options, icon_name, tooltip, class = "", tooltip_placement = "top") {
    # Create an icon button group
    assert_character(inputId, len = 1)
    assert_character(icon_name)
    assert_character(tooltip, len = length(icon_name))
    assert_character(class)
    assert_character(tooltip_placement, len = 1)
    inner = expr_glue(tags$label(`data-toggle` = "tooltip", title = "{tooltip}", class = "btn btn-sm menu-item",
        tags$input(type = "radio", name = "{inputId}", id = "{options}"), tags$span(class = "mdi mdi-{icon_name} menu-icons {class}"))) %>%
        lapply(eval)
   outTag<- div(id = inputId, class = "btn-group-toggle ao-radio-button-grp", `data-toggle` = "buttons", inner)
   attachDependencies( outTag, html_dependency_material_icons())
    # Returns: [HTML]
}
#' @export
icon_radio_group<-
  function (inputId, options, icon_name, tooltip, class = "",
            tooltip_placement = "top",size='sm')
  {
    assert_character(inputId, len = 1)
    assert_character(icon_name)
    assert_character(tooltip, len = length(icon_name))
    assert_character(class)
    assert_character(tooltip_placement, len = 1)
    inner = expr_glue(tags$label(`data-bs-toggle` = "tooltip",
                                 title = "{tooltip}", class = "btn btn-{size} menu-item",
                                 tags$input(type = "radio", name = "{inputId}",class='btn-check',
                                            id = "{options}"), tags$span(class = "mdi mdi-{icon_name} menu-icons {class}"))) %>%
      lapply(eval)
    outTag <- div(id = inputId, class = "btn-group-toggle ao-radio-button-grp",
                  inner)
    attachDependencies(outTag, html_dependency_material_icons())
  }
