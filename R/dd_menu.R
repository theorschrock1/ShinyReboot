#' Create a drop down menu list.
#'
#' For use inside ml_dropdown

#' @name dd_menu
#' @param ...
#' @param id  [character]  Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @return \code{dd_menu}: [HTML]
#' @examples

#'  header = 'Drop Down'

#'  ml_dropdown(class = 'multi-level-dropdown', dd_header(header,

#'  id = label2id(header), class = 'menu-text', carat = FALSE),

#'  dd_menu(id = label2id(header), class = 'shadow', dd_item(id = 'option1',

#'  label = 'Option 1'), dd_item(id = 'option2', label = 'Option 2'),

#'  dd_item(id = 'option3', label = 'Option 3')))

#' @export
dd_menu <- function(..., id, class = "") {
    # Create a drop down menu list.  For use inside ml_dropdown
    assert_character(id, len = 1)
    assert_character(class, len = 1)
    tags$div(class = glue("dropdown-menu {class}"), `aria-labelledby` = id, ...)
    # Returns: [HTML]
}
