#' Create a filter shelf binding.

#' @name data_filters
#' @param inputId  \code{[string]}
#' @param ... html attributes or children.  Filters should have the class 'data-filter'
#' @return \code{data_filters}: \code{[html]}
#' @examples

#'  data_filters(inputId = 'sd')
#' @export
data_filters <- function(inputId, ...) {
    # Create a filter shelf binding
    assert_string(inputId)
    div(...) %>% tagAppendAttributes(id = inputId, class = "filter-shelf") %>% attachDependencies(html_dependency_filter_shelf(),
        append = TRUE)
    # Returns: \code{[html]}
}
