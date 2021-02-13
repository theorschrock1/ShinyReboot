#' Update a radio slider input.

#' @name update_radio_slider_input
#' @param ...
#' @param inputId  \code{[string]}
#' @param range  \code{[atomic]}  Defaults to \code{NULL}
#' @param selected  \code{[choice]}  Possible values: \code{range}.  NULL is ok.  Defaults to \code{NULL}
#' @param label  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{update_radio_slider_input}: \code{[invisible(NULL)]}
#' @examples

#'  update_radio_slider_input(inputId = 'myid', range = LETTERS,
#'  label = 'new_label', selected = 'A')
#' @export
update_radio_slider_input <- function(..., inputId, range = NULL, selected = NULL, label = NULL, 
    session = getDefaultReactiveDomain()) {
    # Update a radio slider input
    dots = assert_named(list(...))
    if (nnull(range)) {
        assert_atomic(range)
        assert_choice(selected, choices = range, null.ok = TRUE)
    }
    select2 = selected
    assert_length(select2, len = 1, null.ok = TRUE)
    assert_string(label, null.ok = TRUE)
    assert_string(inputId)
    value = list(values = range, from = selected)
    message = drop_nulls(list(value = drop_nulls(value), label = label, data = drop_nulls(dots) %or% 
        NULL))
    if (is.null(session)) {
        print("Warning: NULL session: returning message")
        return(message)
    }
    updateInput(inputId, value = message, session = session)
    # Returns: \code{[invisible(NULL)]}
}
