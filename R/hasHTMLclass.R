#' Test is a shiny tag as a specific html class.

#' @name hasHTMLclass
#' @param x  [class]
#' @param class  [character]
#' @return \code{hasHTMLclass}: Logical(1)
#' @examples

#'  x = div(class = 'class1 active show') 

#'  hasHTMLclass(x, 'active') 

#'  hasHTMLclass(x, c('active', 'show')) 

#'  hasHTMLclass(x, c('active', 'class2')) 

#'  hasHTMLclass(x, c('class1 show')) 

#' @export
hasHTMLclass <- function(x, class) {
    # Test is a shiny tag as a specific html class
    assert_class(x, "shiny.tag")
    assert_character(class)
    class = unlist(str_split(class, "\\s+"))
    classes <- unlist(str_split(tagGetAttribute(x, "class"), "\\s+"))
    all(class %in% classes)
    # Returns: Logical(1)
}
