#' Create nav list content link to a navList.
#'
#' Should be used in conjunction with navList().

#' @name navListContent
#' @param ...
#' @param nav_id  [character]  Must have an exact length of 1.  NULL is ok.
#' @param class  [character]  Must have an exact length of 1.  NULL is ok.  Defaults to ''
#' @return \code{navListContent}: html
#' @examples

#'  tagList(navList(nav_id = 'data', class = 'main-nav', type = 'pills',
#'  format = 'justified', navItem(tab_id = 'one', 'One',
#'  active = TRUE), navItem(tab_id = 'two', 'Two')),
#'  navListContent(nav_id = 'data', div(id = 'one', 'one'),
#'  div(id = 'two', 'two')))

#' @export
navListContent <- function(..., nav_id, class = "") {
    # Create nav list content link to a navList.  Should be used in conjunction with
    # navList().
    assert_character(nav_id, len = 1, null.ok = TRUE)
    assert_character(class, len = 1, null.ok = TRUE)
    #dots = enexprs(...)
    dots=list(...)
    ids = sapply(dots, function(x) x$attribs$id)
    if (l(unlist(ids)) != l(ids))
        g_stop("All inner elements should have unique ids")
    if (anyDuplicated(ids))
        g_stop("All inner elements should have unique ids")
    dots = lapply(dots, function(x, nav_id) {
        x$attribs$id = glue("{nav_id}-{x$attribs$id}")
       x= tagAppendAttributes(x,
        role = "tabpanel",
       `aria-labelledby` = glue("{x$attribs$id}-tab"),
        class="tab-pane fade")
        x
    }, nav_id = nav_id)
    append_class(dots[[1]])<-"active show"
    expr_eval(div(class = glue("tab-content {class}"), id = glue("{nav_id}-tabContent"),
        !!!dots))
    # Returns: html
}


