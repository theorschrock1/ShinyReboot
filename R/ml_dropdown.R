#' Create a multi level drop down.
#'
#'

#' @name ml_dropdown
#' @param ...
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @param is_submenu  [logical]  Defaults to FALSE
#' @return \code{ml_dropdown}: [HTML]
#' @examples

#'  header = 'Drop Down'

#'  ml_dropdown(class = 'multi-level-dropdown', dd_header(header,

#'  id = label2id(header), class = 'menu-text', carat = FALSE),

#'  dd_menu(id = label2id(header), class = 'shadow', dd_item(id = 'option1',

#'  label = 'Option 1'), dd_item(id = 'option2', label = 'Option 2'),

#'  dd_item(id = 'option3', label = 'Option 3')))

#' @export
ml_dropdown <- function(..., class = "", is_submenu = FALSE) {
    # Create a multi level drop down.
    assert_character(class,len = 1)
    assert_logical(is_submenu,len=1)
    if(is_submenu==F) {
        tags$div(class=glue("dropdown {class}"),
                 ...)
    }else{
        tags$li(class=glue("dropdown {class}"),
                ...)
    }
    # Returns: [HTML]
}
