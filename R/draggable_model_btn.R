#' Create a button to show or hide a draggable model.

#' @name draggable_model_btn
#' @param ...
#' @param inputId  \code{[string]}
#' @param toggleId  \code{[string]}
#' @param outerTag  \code{[string]}  Defaults to \code{'button'}
#' @return \code{draggable_model_btn}: \code{[html]}
#' @examples

#'  draggable_model_btn(inputId = 'drag_btn', toggleId = 'drag',
#'  'Show')
#'  draggable_model_btn(inputId = 'drag_btn', toggleId = 'drag',
#'  'Show', outerTag = 'div')
#' @export
draggable_model_btn <- function(..., inputId, toggleId, outerTag = "button") {
    # Create a button to show or hide a draggable model
    assert_string(inputId)
    assert_string(toggleId)
    assert_string(outerTag)
    restoreInput(inputId, default = NULL)
    dots = list(...)
    tag <- expr(tags$button(!!!dots))
    tag[[1]][[3]] <- sym(outerTag)
    tag <- eval(tag) %>% tagAppendAttributes(id = inputId, class = "toggle-draggable-model", `data-toggle` = toggleId)
    as_shiny_button(tag)
    # Returns: \code{[html]}
}
