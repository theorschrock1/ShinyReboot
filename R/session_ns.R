#' Get a session namespace
#'
#'
#' @name session_ns
#' @param session the shiny session.
#' @return the session's namespace function

#' @export
session_ns=function(session=getDefaultReactiveDomain()){
  if(is.null(session)||is.null(session$ns)){
    return(function(x)x)
  }
  session$ns
}
