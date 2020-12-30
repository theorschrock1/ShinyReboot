#' Update an editable class.

#' @name update_editable
#' @param inputId  \code{[string]}
#' @param data_id  \code{[string]}
#' @param value  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param trigger_edit  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{update_editable}: \code{[invisible(NULL)]}
#' @export
update_editable <- function(inputId, data_id, value = NULL, trigger_edit = FALSE, session = getDefaultReactiveDomain()) {
    # Update an editable class
    assert_string(inputId)
    assert_string(data_id)
    assert_string(value, null.ok = TRUE)
    assert_logical(trigger_edit, len = 1)
    if (trigger_edit == FALSE) 
        trigger_edit <- NULL
    message = drop_nulls(list(id = data_id, value = value, edit = trigger_edit))
    session$sendInputMessage(inputId, message)
    return(invisible(NULL))
    # Returns: \code{[invisible(NULL)]}
}
