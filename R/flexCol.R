#' Create a BS4 flex column.

#' @name flexCol
#' @param ... html attributes and inner html
#' @return \code{flexCol}: HTML
#' @export
flexCol <- function(...) {
    # Create a BS4 flex column

    out<-div(...)
    out %>% tagAppendAttributes(class='d-flex flex-column')
    # Returns: HTML
}
