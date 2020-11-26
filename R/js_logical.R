#' Convert R TRUE/FALSE to HTML/JS true/false.

#' @name js_logical
#' @param x  [logical]
#' @return \code{js_logical}: character
#' @examples

#'  js_logical(c(T, F)) 

#'  js_logical(c(TRUE, FALSE)) 

#' @export
js_logical <- function(x) {
    # Convert R TRUE/FALSE to HTML/JS true/false
    assert_logical(x)
    tolower(as.character(x))
    # Returns: character
}
