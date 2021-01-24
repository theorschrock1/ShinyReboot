#' Update a checkbox_grou_input.

#' @name update_checkbox_group_input
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param choices  \code{[atomic_vector]}  Defaults to \code{NULL}
#' @param selected  \code{[choice]}  Possible values: \code{choices}.  NULL is ok.  Defaults to \code{NULL}
#' @param data_attrs  \code{[list]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{update_checkbox_group_input}: \code{[invisible(NULL)]}
#' @export
update_checkbox_group_input <- function(inputId, label = NULL, choices = NULL, selected = NULL, 
    data_attrs = NULL) {
    # Update a checkbox_grou_input
    assert_string(inputId)
    assert_string(label, null.ok = TRUE)
    assert_atomic_vector(choices)
    assert_choice(selected, choices = choices, null.ok = TRUE)
    assert_list(data_attrs, null.ok = TRUE)
    message = drop_nulls(list(label = label, options = choices, selected = selected, 
        data_attrs = data_attrs))
    updateInput(inputId = inputId, value = message)
    invisible(NULL)
    # Returns: \code{[invisible(NULL)]}
}
