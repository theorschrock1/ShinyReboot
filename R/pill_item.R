#' Create pill items.

#' @name pill_item
#' @param id  [character] the pill ids
#' @param label  [character] the pill labels
#' @param type  [character]  Must have an exact length of or equal to one of the following: [1,length(id)].  Defaults to 'measure'
#' @return \code{pill_item}: [html]
#' @examples

#'  pill_card(pill_item(id = c('sales', 'transactions', 'traffic',
#'  'basket size'), label = c('sales', 'transactions', 'traffic',
#'  'basket size')), inputId = 'one', name = 'Chart', icon = 'test')

#' @export
pill_item <- function(id, label, type = "measure") {
    # Create pill items
    assert_character(id)
    assert_character(label, l(id))
    order=ifelse(type=='measure',1,0)
    assert_any(type, check_character(len = 1), check_character(len = length(id)))
    out <- expr_glue("tags$div(id=\"{id}\",class=glue(\"pill-item pill-{type} order-{order}\"),\n       tags$span(\"{label}\",class=\"pill-label\"),\n       icon(\"angle-down\",class=\"ghost-icon\"))") %>%
        exprs_eval()
    out
    # Returns: [html]
}
