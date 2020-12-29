#' Create a action button in a dropdown menu.

#' @name dropdown_button
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}
#' @return \code{dropdown_button}: \code{[html]}
#' @examples

#'  dropdown_button(inputId = 'edit', label = 'Edit...')
#' @export
dropdown_button <- function(inputId, label) {
    # Create a action button in a dropdown menu
    assert_string(inputId)
    assert_string(label)
    div(class = "btn-group-toggle dropdown-group", div(id = inputId, role = "button", class = "btn dropdown-item dropdown-btn  action-item", 
        tags$span(class = "mdi mdi-check-bold icon-left"), tags$span(class = "dropdown-label", label), tags$span(class = "mdi mdi-menu-right float-right icon-right")))
    # Returns: \code{[html]}
}
