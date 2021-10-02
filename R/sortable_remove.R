#' insert html into a sortable div.

#' @name sortable_remove
#' @param inputId  \code{[string]} The sortable inputId
#' @param data_id  \code{[character]}  The a vector of item data ids to remove.
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{sortable_insert}: \code{[invisible(NULL)]}
#' @examples

#' @export
sortable_remove <- function(inputId, data_id , session = getDefaultReactiveDomain()) {
  # insert html into a sortable div
  assert_string(inputId)

  assert_character(data_id)

  ns <- session_ns(session)
  inputId=ns(inputId)
  selector <- glue("#{inputId} > [data-id=\"{data_id}\"]")

  lapply(selector,removeUI,session = session,immediate = TRUE)
   return(invisible(NULL))
  # Returns: \code{[invisible(NULL)]}
}
