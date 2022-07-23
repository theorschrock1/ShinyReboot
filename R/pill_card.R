#' Create a pill card div.

#' @name pill_card
#' @param ...
#' @param inputId  \code{[string]}  Must have an exact length of 1.
#' @param name  \code{[string]}  NULL is ok.  Defaults to NULL
#' @param icon  \code{[string]}  Must have an exact length of 1.
#' @param type  \code{[choice]}  Possible values: \code{c( 'row', 'column')}.  Defaults to 'column'
#' @param sortable  \code{[logical]}  Must have an exact length of 1.  Defaults to TRUE
#' @param sort_ops  \code{[class('sortable_options')]}  Should be the output of a sortable_options call. See \code{?sortable_options} for details.
#' @param default_css  \code{[logical]}  Use default css. Defaults to True/
#' @return \code{pill_card}: [htmlTag(div)]
#' @examples

#'  pill_card(pill_item(id = c('sales', 'transactions', 'traffic',
#'  'basket size'), label = c('sales', 'transactions', 'traffic',
#'  'basket size')), inputId = 'one', name = 'Chart', icon = 'test')

#' @export
pill_card <- function(..., inputId, name = NULL, icon, type = "column", sortable = TRUE,sort_ops=sortable_options(),default_css=TRUE) {
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
        out = div(
            class = glue("pill-card-{type}"),
            header,
            sortableDiv(
                inputId = inputId,
                class = glue("d-flex flex-{type} flex-fill flex-wrap bg-transparent shelf"),
                options = sort_ops,
                ...
            )
        )
    }else{
    out<-div(class = glue("pill-card-{type}"), header, div(class = glue("d-flex flex-{type} flex-wrap bg-transparent shelf"),
        ...))
    }
    if(default_css){
    htmlDependencies(out)<-
        html_dependency_pill_card()
    }
    out
    # Returns: [htmlTag(div)]
}
