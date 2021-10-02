#' Get a session namespace
#'
#'
#' @name get_session_ns
#' @param session the shiny session.
#' @return the session's namespace function

#' @export
get_session_ns=function(session=getDefaultReactiveDomain()){
  if(is.null(session$ns)){
    return(function(x)x)
  }
  session$ns
}
