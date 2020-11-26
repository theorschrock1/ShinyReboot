#' Append the class of a shiny tag.

#' @name append_class
#' @param x  [class]
#' @param class
#' @return \code{append_class}: shiny tag
#' @examples

#'  x <- div(class = 'class1')

#'  append_class(x) <- 'new_class'

#'  x

#' @export
append_class <- function(x, class) {
    # Append the class of a shiny tag
    assert_class(x, "shiny.tag")
    tagAppendAttributes(x, class = class)
    # Returns: shiny tag
}
#' @export
`append_class<-`<-function(x,value){
  append_class(x,value)
}
