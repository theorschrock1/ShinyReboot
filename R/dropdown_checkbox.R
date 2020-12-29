#' Create a checkbox in a dropdown menu.

#' @name dropdown_checkbox
#' @param inputId  \code{[string]}
#' @param label
#' @param value  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @return \code{dropdown_checkbox}: \code{[html]}
#' @examples

#'  dropdown_checkbox(inputId = 'filter', value = FALSE, label = 'Show Filter')
#' @export
dropdown_checkbox <- function(inputId, label, value = FALSE) {
    # Create a checkbox in a dropdown menu
    assert_string(inputId)
    assert_logical(value, len = 1)
    inputId <- paste0("checkbox_", inputId)
    input = tags$input(type = "checkbox", name = inputId)
    if (value) 
        input <- input %>% tagAppendAttributes(checked = "checked")
    inner <- div(role = "button", class = "btn dropdown-item dropdown-btn  input-item", input, tags$span(class = "mdi mdi-check-bold icon-left"), 
        tags$span(class = "dropdown-label", label), tags$span(class = "mdi mdi-menu-right float-right icon-right"))
    if (value) 
        inner %>% tagAppendAttributes(class = "active")
    div(id = inputId, class = "btn-group-toggle dropdown-group ao-check-button", `data-toggle` = "buttons", 
        inner)
    # Returns: \code{[html]}
}
