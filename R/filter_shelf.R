#' Create a filter shelf binding.

#' @name filter_shelf
#' @param inputId  \code{[string]}
#' @param ...
#' @return \code{filter_shelf}: \code{[html]}
#' @examples

#'  filter_shelf(inputId = 'sd')
#' @export
filter_shelf <- function(inputId, ...) {
    # Create a filter shelf binding
    assert_string(inputId)
    div(...) %>% tagAppendAttributes(id = inputId, class = "data-filter") %>% attachDependencies(html_dependency_filter_shelf(), 
        append = TRUE)
    # Returns: \code{[html]}
}
