#' Get or set the class of a shiny tag.

#' @name html_class
#' @param x  [class]
#' @return \code{html_class}: character(1)
#' @examples

#'  x <- div()

#'  html_class(x)

#'  html_class(x) <- 'new_class'

#'  html_class(x)

#' @export
html_class <- function(x) {
    # Get or set the class of a shiny tag
    assert_class(x, "shiny.tag")
    x$attribs$class
    # Returns: character(1)
}
#' @export
`html_class<-`<-function(x,value){
  assert_class(x,"shiny.tag")
  x$attribs$class<-value
  invisible(x)
}
