#' Create a BS4 flex row.

#' @name flexRow
#' @param ... html attributes and inner html
#' @return \code{flexRow}: HTML
#' @export
flexRow <- function(...) {
    # Create a BS4 flex row


    out<-div(...)
    out %>% tagAppendAttributes(class='d-flex flex-row')
    # Returns: HTML
}
