#' Create a draggable model.

#' @name draggable_model
#' @param inputId  \code{[string]}
#' @param left  \code{[number]}  Must be greater than \code{0}.  Must be less than \code{100}.
#' @param top  \code{[number]}  Must be greater than \code{0}.  Must be less than \code{100}.
#' @param width  \code{[string]}  All non-missing elements must comply to regex pattern \code{'''\\d+px|\\d+\\%'''}.  NULL is ok.  Defaults to \code{NULL}
#' @param ...
#' @return \code{draggable_model}: \code{[html]}
#' @examples

#'  draggable_model(inputId = 'drag', left = 10, top = 10, width = '30%')
#'  draggable_model(inputId = 'drag', class = 'myModel', left = 10,
#'  top = 10, width = '30%', div('someContent'))
#'  draggable_model(inputId = 'drag', left = 100, top = 10, width = '30px')
#'  draggable_model(inputId = 'drag', left = 120, top = 10, width = '30%')
#' @export
draggable_model <- function(inputId, left, top, width = NULL, ...) {
    # Create a draggable model
    assert_string(inputId)
    assert_number(left, lower = 0, upper = 100)
    assert_number(top, lower = 0, upper = 100)
    assert_string(width, pattern = "\\d+px|\\d+\\%", null.ok = TRUE)
    wd = NULL
    if (nnull(width)) 
        wd = paste0("width:", width, ";")
    style = c(glue("left:{left}%;top:{top}%;", wd) %sep% ";")
    out <- div(...) %>% tagAppendAttributes(id = inputId, class = "draggableModel", style = style)
    attachDependencies(out, html_dependency_draggableModel())
    # Returns: \code{[html]}
}
