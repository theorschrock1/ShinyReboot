#' Turn a html label into an shiny input id.

#' @name label2id
#' @param x  [character]
#' @return \code{label2id}: tolower(str_replace_all([character(1)],'\s','_')
#' @examples

#'  label2id('Open File') 

#' @export
label2id <- function(x) {
    # Turn a html label into an shiny input id
    assert_character(x)
    tolower(str_replace_all(x, "\\s+", "_"))
    # Returns: tolower(str_replace_all([character(1)],'\s','_')
}
