#' Set data on an HTML element/s.

#' @name set_html_data
#' @param selector  \code{[string]}
#' @param data  \code{[named]}
#' @param trigger_event  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{set_html_data}: \code{[invisible(NULL)]}
#' @export
set_html_data <- function(selector, data, trigger_event = NULL) {
    # Set data on an HTML element/s
    assert_string(selector)
    assert_string(trigger_event, null.ok = TRUE)
    assert_named(data)
    message <- drop_nulls(list(selector = selector, data = data, trigger = trigger_event))
    sendCustomMessage("shinyReboot-sethtmldata", message = message)
    return(invisible(NULL))
    # Returns: \code{[invisible(NULL)]}
}
