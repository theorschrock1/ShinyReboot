#' Get or set the id of a shiny tag.

#' @name html_id
#' @param x  [class]
#' @return \code{html_id}: character(1)
#' @examples

#'  x <- div()

#'  html_id(x)

#'  html_id(x) <- 'ds'

#'  html_id(x)

#' @export
html_id <- function(x) {
    # Get or set the id of a shiny tag
    assert_class(x, "shiny.tag")
    x$attribs$id
    # Returns: character(1)
}
#' @export
`html_id<-`<-function(x,value){
  assert_class(x,"shiny.tag")
  x$attribs$id<-value
  invisible(x)
}
