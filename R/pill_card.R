#' Create a pill card div.

#' @name pill_card
#' @param ...
#' @param inputId  [character]  Must have an exact length of 1.
#' @param name  [character]  NULL is ok.  Defaults to NULL
#' @param icon  [character]  Must have an exact length of 1.
#' @param type  [choice]  Possible values: c('c', 'row', 'column').  Defaults to 'column'
#' @param sortable  [logical]  Must have an exact length of 1.  Defaults to TRUE
#' @return \code{pill_card}: [htmlTag(div)]
#' @examples

#'  pill_card(pill_item(id = c('sales', 'transactions', 'traffic',

#'  'basket size'), label = c('sales', 'transactions', 'traffic',

#'  'basket size')), inputId = 'one', name = 'Chart', icon = 'test')

#' @export
pill_card <- function(..., inputId, name = NULL, icon, type = "column", sortable = TRUE) {
    # Create a pill card div
    header = NULL
    assert_character(inputId, len = 1)
    assert_character(name, null.ok = TRUE)
    if(!missing(icon))assert_character(icon, len = 1)
    assert_choice(type, choices = c("row", "column"))
    assert_logical(sortable, len = 1)
    if (!is.null(name)) {
        header = div(class = "handle", icon_mdi(icon), name)
    }
    if (sortable) {
        return(div(class = glue("pill-card-{type}"), header, sortable_div(inputId = inputId,
            class = glue("d-flex flex-{type} flex-fill flex-wrap bg-transparent shelf"),
            ...)))
    }
    div(class = glue("pill-card-{type}"), header, div(class = glue("d-flex flex-{type} flex-wrap bg-transparent shelf"),
        ...))
    # Returns: [htmlTag(div)]
}
