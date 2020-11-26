#' Create an icon tool bar wrapper.

#' @name icon_tool_bar
#' @param ...
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @return \code{icon_tool_bar}: [HTML]
#' @examples

#'  icon_tool_bar(icon_button_group(inputId = c('undo', 'redo',

#'  'save'), c('undo', 'redo', 'content-save-outline'), c('Undo',

#'  'Redo', 'Save')), icon_button_group(c('data_source_new',

#'  'data_source_refresh', 'pause_data_updates'), c('database-plus',

#'  'database-refresh', 'database-lock'), c('New data source',

#'  'Refresh data source', 'Pause auto updates')), icon_radio_group(inputId = 'sort_options',

#'  c('sort_remove', 'sort_ascending', 'sort_descending'),

#'  c('sort-variant-remove', 'sort-ascending', 'sort-descending'),

#'  c('Clear sort', 'Sort ascending', 'Sort descending')))

#' @export
icon_tool_bar <- function(..., class = "") {
    # Create an icon tool bar wrapper
    assert_character(class, len = 1)
    flexRow(class = glue("icon-tool-bar {class}"), add_dividers(..., type = "|"))
    # Returns: [HTML]
}
