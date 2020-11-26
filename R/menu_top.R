#' A wrapper for a full width top menu bar.

#' @name menu_top
#' @param ...
#' @return \code{menu_top}: [HTML]
#' @examples

#'  menu_top(
#'  main_menu_bar(File = list('New', 'Open', 'Save',
#'  list(l2 = list('one', 'two', 'three', list(l3 = list('one',
#'  'two', 'three'))))), Data = .('New data source',
#'  'Paste'), View = .('Graph', 'Dashboard')), icon_tool_bar(menu_icons_buttons(inputId = c('undo',
#'  'redo', 'save'), c('undo', 'redo', 'content-save-outline'),
#'  c('Undo', 'Redo', 'Save')), sep(), menu_icons_buttons(c('data_source_new',
#'  'data_source_refresh', 'pause_data_updates'), c('database-plus',
#'  'database-refresh', 'database-lock'), c('New data source',
#'  'Refresh data source', 'Pause auto updates')), sep(),
#'  menu_icons_radio(inputId = 'sort_options', c('sort_remove',
#'  'sort_ascending', 'sort_descending'), c('sort-variant-remove',
#'  'sort-ascending', 'sort-descending'), c('Clear sort',
#'  'Sort ascending', 'Sort descending')), sep()))

#' @export
menu_top <- function(...) {
    # A wrapper for a full width top menu bar
    div(class = "menu-wrapper", ...)
    # Returns: [HTML]
}
