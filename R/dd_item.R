#' Create a drop down menu item.

#' @name dd_item
#' @param ...
#' @param id  [character]  Must have an exact length of 1.
#' @param label  [character]  Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @return \code{dd_item}: [HTML]
#' @examples

#'  dd_item(id = 'option2', label = 'Option 2', ) 

#' @export
dd_item <- function(..., id, label, class = "") {
    # Create a drop down menu item
    assert_character(id, len = 1)
    assert_character(label, len = 1)
    assert_character(class, len = 1)
    tags$li(tags$a(id = id, class = glue("dropdown-item {class}"), href = "#", label), ...)
    # Returns: [HTML]
}
