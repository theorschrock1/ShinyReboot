#' create an AO sheet binding.

#' @name ao_sheet
#' @param ...
#' @param inputId  \code{[string]}
#' @return \code{ao_sheet}: \code{[HTML]}
#' @examples

#'  ao_sheet(inputId = 'myid')
#' @export
ao_sheet <- function(..., inputId) {
    # create an AO sheet binding
    assert_string(inputId)
    div(...) %>% tagAppendAttributes(id = inputId) %>% attachDependencies(html_dependency_ao_sheet(), 
        append = TRUE)
    # Returns: \code{[HTML]}
}
