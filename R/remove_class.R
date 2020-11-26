#' Remove the class of a shiny tag.

#' @name remove_class
#' @param x  [class]
#' @param class  [character]
#' @return \code{remove_class}: shiny tag
#' @examples

#'  x <- div(class = 'class1 class2 active show')

#'  remove_class(x) <- 'active'

#'  x

#'  remove_class(x) <- 'class1 active'

#'  x

#'  x <- div(class = 'class1 class2 active show')

#'  remove_class(x) <- c('class1', 'active')

#'  x

#' @export
remove_class <- function(x, class) {
    # Remove the class of a shiny tag
    assert_class(x, "shiny.tag")
    assert_character(class)
    class = unlist(str_split(class, "\\s+"))
    classes <- unlist(str_split(tagGetAttribute(x, "class"), "\\s+"))
    x$attribs$class = classes %NIN% class %sep% " "
    x
    # Returns: shiny tag
}
#' @export
`remove_class<-`<-function(x,value){
    remove_class(x,value)
}
