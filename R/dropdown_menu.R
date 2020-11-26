#' Create a drop down menu.

#' @name dropdown_menu
#' @param ...
#' @param label  [character]  Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @return \code{dropdown_menu}: HTML
#' @examples

#'  dropdown_menu(label = 'File', class = 'menu-item', dropdown_btn_group(inputIds = letters[1:3],

#'  labels = c('Add to Sheet', 'New Calculation', 'Show Filter'),

#'  types = c('action', 'action', 'checkbox')), dropdown_btn_group(inputIds = letters[4:6],

#'  labels = c('Copy', 'Duplicate', 'Edit'), types = c('action',

#'  'action', 'model')), dropdown_radio_group(inputId = 'letters',

#'  options = letters[1:4], labels = c('Currency', 'Percentage',

#'  'Number', 'Units')), dropdown_submenu(label = 'More Options',

#'  dropdown_btn_group(inputIds = letters[1:2], labels = letters[1:2],

#'  types = c('action', 'action'))))

#' @export
dropdown_menu <- function(..., label, class = "") {
    # Create a drop down menu
    assert_character(label, len = 1)
    assert_character(class, len = 1)
    ml_dropdown(class = class, is_submenu = FALSE, dd_header(label, id = label2id(label),
        class = "dropdown-btn menu-text", carat = FALSE, is_submenu = FALSE), dd_menu(id = label2id(label),
        class = "shadow", add_dividers(..., type = "-")))
    # Returns: HTML
}
