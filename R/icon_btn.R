#' Create an icon button.

#' @name icon_btn
#' @param inputId  \code{[string]}
#' @param icon  \code{[string]}
#' @param toggleId  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param tooltip  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param btn_style  \code{[string]}  Defaults to \code{'light'}
#' @param size  \code{[choice]}  Defaults to \code{'sm'}
#' @param ...
#' @return \code{icon_btn}: \code{[html]}
#' @examples

#'  icon_btn(inputId = 'hi', icon = 'pencil', toggleId = NULL)
#'  icon_btn(inputId = 'hi', icon = 'pencil', toggleId = 'model')
#'  icon_btn(inputId = 'hi', icon = 'pencil', toggleId = 'model',
#'  tooltip = 'launch model', size = 'md')
#' @export
icon_btn <- function(inputId, icon, toggleId = NULL, tooltip = NULL, btn_style = "light", size = "sm", 
    ...) {
    # Create an icon button
    assert_string(inputId)
    assert_string(icon)
    assert_string(btn_style)
    assert_choice(size, c("sm", "md", "lg"))
    assert_string(tooltip, null.ok = TRUE)
    assert_string(toggleId, null.ok = TRUE)
    tag <- tags$button(id = inputId, ..., icon_mdi(icon))
    size <- if (size == "md") 
        "" else paste0(" btn-", size)
    toggle_class <- if (nnull(toggleId)) 
        " toggle-draggable-model" else ""
    toggle_tooltip <- if (nnull(tooltip)) 
        "tooltip" else NULL
    tag %>% tagAppendAttributes(class = glue("icon-btn action-button btn{size} shadow-none btn-{btn_style}{toggle_class}"), 
        `data-toggle-model` = toggleId, title = tooltip, `data-toggle` = toggle_tooltip)
    # Returns: \code{[html]}
}
