#' Create a drop down submenu.

#' @name dropdown_submenu
#' @param ...
#' @param label  [character]  Must have an exact length of 1.
#' @param parent  [NULL]  Defaults to NULL
#' @return \code{dropdown_submenu}: HTML
#' @examples

#'  dropdown_submenu(label = 'More Options', dropdown_btn_group(inputIds = letters[1:2], 

#'  labels = letters[1:2], types = c('action', 'action'))) 

#' @export
dropdown_submenu <- function(..., label, parent = NULL) {
    # Create a drop down submenu
    assert_character(label, len = 1)
    dropdown_btn_group(labels = label, inputIds = label2id(label), types = "submenu", 
        dd_menu(id = label2id(label), class = "submenu", ...))
    # Returns: HTML
}
