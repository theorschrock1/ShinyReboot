#' Create a sortable div.

#' @name sortableDiv
#' @param ... sortable HTML elements.  Each element should have a unqiue `data-id` attribute.
#' @param inputId  \code{[string]}
#' @param options  \code{[class('sortable_options')]}  Should be the output of a sortable_options call. See \code{?sortable_options} for details.
#' @return \code{sortableDiv}: HTML
#' @examples

#'  sortableDiv(class = 'p-1', inputId = 'sortablejs1', div(class = 'm-1 bg-secondary',
#'  `data-id` = 'one', 'one'), div(class = 'm-1 bg-secondary',
#'  `data-id` = 'two', 'two'), div(class = 'm-1 bg-secondary',
#'  `data-id` = 'three', 'three'), options = sortable_options(name = 'things'))

#' @export
sortableDiv <- function(..., inputId, options = sortable_options()) {
    # Create a sortable div
    assert_string(inputId)
    assert_class(options,classes="sortable_options")
    dots <- drop_nulls(list(...))
    attrs = dots[have_name(dots)]
    children = dots[!have_name(dots)]
    children = checkTagListFormat(children)
    if (!all(sapply(children, tagHasAttribute, attr = "data-id")))
        g_stop("All elements in a sortable div must have a `data-id` attribute.")
    sortableTag <- div(id = inputId, class = "sortable-div", !!!children, tags$script(type = "application/json",
        `data-for` = inputId, `data-id` = "sortable-options", options)) %>% tagAppendAttributes(!!!attrs)
    attachDependencies(sortableTag, html_dependency_sortable_JS())
    # Returns: HTML
}
