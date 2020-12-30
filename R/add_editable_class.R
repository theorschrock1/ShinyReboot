#' Add an editable class.

#' @name add_editable_class
#' @param inputId  \code{[string]}
#' @param editable_class  \code{[string]}
#' @param assert_unique  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{add_editable_class}: \code{[html]}
#' @examples

#'  add_editable_class(inputId = 'myid', editable_class = 'pill-item',
#'  assert_unique = TRUE)
#'  add_editable_class(inputId = 'myid', editable_class = 'pill-item',
#'  assert_unique = FALSE)
#' @export
add_editable_class <- function(inputId, editable_class, assert_unique = TRUE) {
    # Add an editable class
    assert_string(inputId)
    assert_string(editable_class)
    assert_logical(assert_unique, len = 1)
    div(id = inputId, class = "editable-text", `data-for` = editable_class, `data-assert_unique` = js_logical(assert_unique)) %>% 
        attachDependencies(html_dependency_editable_text())
    # Returns: \code{[html]}
}
