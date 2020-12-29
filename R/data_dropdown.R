#' Create a data dropdown.

#' @name data_dropdown
#' @param ...
#' @param inputId  \code{[string]}
#' @param target_class  \code{[string]}
#' @param handle_class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{data_dropdown}: \code{[html]}
#' @examples

#'  data_dropdown(dropdown_button(inputId = 'edit', label = 'Edit...'),
#'  dropdown_checkbox(inputId = 'filter', value = FALSE,
#'  label = 'Show Filter'), dropdown_radio_group(inputId = 'radio_nformat',
#'  options = c('currency', 'percentage', 'float', 'integer'),
#'  labels = c('currency', 'percentage', 'float', 'integer')),
#'  dropdown_submenu(label = 'Units', dropdown_radio_group(inputId = 'radio_units',
#'  labels = c('duration', 'distance', 'mass', 'speed'),
#'  options = c('duration', 'distance', 'mass', 'speed'))),
#'  inputId = 'myid', handle_class = 'dropdown-handle', target_class = 'pill-item')
#' @export
data_dropdown <- function(..., inputId, target_class, handle_class = NULL, class = NULL) {
    # Create a data dropdown
    assert_string(inputId)
    assert_string(target_class)
    assert_string(handle_class, null.ok = TRUE)
    assert_string(class, null.ok = TRUE)
    out <- dd_menu(id = inputId, `data-for` = target_class, class = "data_dropdown context-menu shadow", add_dividers(..., 
        type = "-"))
    out = tagAppendAttributes(out, class = class, id = inputId, `data-handle` = handle_class)
    attachDependencies(out, html_dependency_data_dropdown(), append = TRUE)
    # Returns: \code{[html]}
}
